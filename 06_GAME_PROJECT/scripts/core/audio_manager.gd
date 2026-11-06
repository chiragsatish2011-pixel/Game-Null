# audio_manager.gd
# PROJECT NULL — Procedural Audio & Atmosphere Manager
# Target Hardware Baseline: Intel i5-12400F | 16GB RAM | NVIDIA GeForce G210 (1GB VRAM)
# Invariant: Registered as Autoload singleton "AudioManager"
# Invariant: Strictly zero external audio file dependencies; procedural waveform pre-synthesis
extends Node

# Audio Bus Names
const BUS_MASTER: String = "Master"
const BUS_SFX: String = "SFX"
const BUS_AMBIENCE: String = "Ambience"

# Audio Synthesis Configuration
const MIX_RATE: int = 22050 # Lightweight 22.05 kHz retro industrial rate

# Pre-synthesized procedural waveforms
var wav_footstep_1: AudioStreamWAV
var wav_footstep_2: AudioStreamWAV
var wav_lever_clunk: AudioStreamWAV
var wav_clue_inspect: AudioStreamWAV
var wav_clue_close: AudioStreamWAV
var wav_clock_tick: AudioStreamWAV
var wav_clock_tock: AudioStreamWAV
var wav_rain_loop: AudioStreamWAV
var wav_hum_loop: AudioStreamWAV

# SFX Pools (prevents dynamic allocation / GC churn on low-spec hardware)
const SFX_POOL_SIZE: int = 8
const SFX_3D_POOL_SIZE: int = 4
var _sfx_pool: Array[AudioStreamPlayer] = []
var _sfx_3d_pool: Array[AudioStreamPlayer3D] = []
var _sfx_pool_index: int = 0
var _sfx_3d_pool_index: int = 0

# Dedicated Ambient Players
var _ambient_rain_player: AudioStreamPlayer
var _ambient_hum_player: AudioStreamPlayer

# Real-time Procedural AudioStreamGenerator Player & Playback
var _generator_player: AudioStreamPlayer
var _generator_playback: AudioStreamGeneratorPlayback

# Footstep Tracking State
var _last_footstep_pos: Vector3 = Vector3.ZERO
var _has_last_footstep_pos: bool = false
var _footstep_distance_accum: float = 0.0
var _footstep_alternate: bool = false
@export var footstep_stride_length: float = 1.3 # Meters between footsteps

# Clock tick alternation
var _clock_tick_alternate: bool = false

func _ready() -> void:
	_setup_audio_buses()
	_synthesize_all_waveforms()
	_init_sfx_pools()
	_init_ambient_players()
	_init_generator_player()
	_connect_event_bus()
	print("[AudioManager] Initialized successfully. 9 procedural waveforms synthesized, SFX pools & ambient streams active.")

# ==============================================================================
# AUDIO BUS SETUP
# ==============================================================================

func _setup_audio_buses() -> void:
	# Ensure SFX bus exists and routes to Master
	var sfx_idx := AudioServer.get_bus_index(BUS_SFX)
	if sfx_idx == -1:
		AudioServer.add_bus()
		sfx_idx = AudioServer.get_bus_count() - 1
		AudioServer.set_bus_name(sfx_idx, BUS_SFX)
		AudioServer.set_bus_send(sfx_idx, BUS_MASTER)
	
	# Ensure Ambience bus exists and routes to Master
	var amb_idx := AudioServer.get_bus_index(BUS_AMBIENCE)
	if amb_idx == -1:
		AudioServer.add_bus()
		amb_idx = AudioServer.get_bus_count() - 1
		AudioServer.set_bus_name(amb_idx, BUS_AMBIENCE)
		AudioServer.set_bus_send(amb_idx, BUS_MASTER)

# ==============================================================================
# EVENT BUS SIGNAL BINDINGS
# ==============================================================================

func _connect_event_bus() -> void:
	if not Engine.has_singleton("EventBus") and not get_node_or_null("/root/EventBus"):
		push_warning("AudioManager: EventBus autoload not found. Skipping signal connection.")
		return
	
	EventBus.interaction_triggered.connect(_on_interaction_triggered)
	EventBus.clue_inspected.connect(_on_clue_inspected)
	EventBus.clue_closed.connect(_on_clue_closed)
	EventBus.player_moved.connect(_on_player_moved)

func _on_interaction_triggered(interactable: Node3D) -> void:
	if interactable != null and is_instance_valid(interactable):
		play_mechanical_lever(interactable.global_position)
	else:
		play_mechanical_lever()

func _on_clue_inspected(_clue_id: String, _clue_data: Dictionary) -> void:
	play_clue_inspect()

func _on_clue_closed() -> void:
	play_clue_close()

func _on_player_moved(pos: Vector3) -> void:
	if not _has_last_footstep_pos:
		_last_footstep_pos = pos
		_has_last_footstep_pos = true
		return
	
	var dist: float = pos.distance_to(_last_footstep_pos)
	if dist > 5.0: # Discontinuity / teleportation safety guard
		_last_footstep_pos = pos
		return
	
	_footstep_distance_accum += dist
	_last_footstep_pos = pos
	
	if _footstep_distance_accum >= footstep_stride_length:
		_footstep_distance_accum = 0.0
		play_footstep(pos)

# ==============================================================================
# SFX POOL INITIALIZATION & PLAYBACK
# ==============================================================================

func _init_sfx_pools() -> void:
	# 2D non-positional / global SFX pool
	for i in range(SFX_POOL_SIZE):
		var p := AudioStreamPlayer.new()
		p.name = "SFX_Player_%d" % i
		p.bus = BUS_SFX
		add_child(p)
		_sfx_pool.append(p)
	
	# 3D positional SFX pool
	for i in range(SFX_3D_POOL_SIZE):
		var p3d := AudioStreamPlayer3D.new()
		p3d.name = "SFX_3D_Player_%d" % i
		p3d.bus = BUS_SFX
		p3d.unit_size = 3.0
		p3d.max_distance = 35.0
		p3d.attenuation_model = AudioStreamPlayer3D.ATTENUATION_INVERSE_DISTANCE
		p3d.area_mask = 1 # Godot 4.7 area mask compatibility invariant
		add_child(p3d)
		_sfx_3d_pool.append(p3d)

func play_sfx(stream: AudioStream, volume_db: float = 0.0, pitch_scale: float = 1.0) -> AudioStreamPlayer:
	if stream == null or _sfx_pool.is_empty():
		return null
	
	# Find free player or advance round-robin
	var player: AudioStreamPlayer = null
	for p in _sfx_pool:
		if not p.playing:
			player = p
			break
	if player == null:
		player = _sfx_pool[_sfx_pool_index]
		_sfx_pool_index = (_sfx_pool_index + 1) % _sfx_pool.size()
	
	player.stream = stream
	player.volume_db = volume_db
	player.pitch_scale = pitch_scale
	player.play()
	return player

func play_sfx_3d(stream: AudioStream, global_pos: Vector3, volume_db: float = 0.0, pitch_scale: float = 1.0, max_dist: float = 35.0) -> AudioStreamPlayer3D:
	if stream == null or _sfx_3d_pool.is_empty():
		return null
	
	var player: AudioStreamPlayer3D = null
	for p in _sfx_3d_pool:
		if not p.playing:
			player = p
			break
	if player == null:
		player = _sfx_3d_pool[_sfx_3d_pool_index]
		_sfx_3d_pool_index = (_sfx_3d_pool_index + 1) % _sfx_3d_pool.size()
	
	player.global_position = global_pos
	player.max_distance = max_dist
	player.stream = stream
	player.volume_db = volume_db
	player.pitch_scale = pitch_scale
	player.play()
	return player

# ==============================================================================
# AMBIENCE PLAYERS INITIALIZATION
# ==============================================================================

func _init_ambient_players() -> void:
	# Persistent rain loop
	_ambient_rain_player = AudioStreamPlayer.new()
	_ambient_rain_player.name = "AmbientRainPlayer"
	_ambient_rain_player.bus = BUS_AMBIENCE
	_ambient_rain_player.volume_db = -15.0
	_ambient_rain_player.stream = wav_rain_loop
	add_child(_ambient_rain_player)
	_ambient_rain_player.play()
	
	# Persistent 50Hz Victorian industrial electrical hum loop
	_ambient_hum_player = AudioStreamPlayer.new()
	_ambient_hum_player.name = "AmbientHumPlayer"
	_ambient_hum_player.bus = BUS_AMBIENCE
	_ambient_hum_player.volume_db = -18.0
	_ambient_hum_player.stream = wav_hum_loop
	add_child(_ambient_hum_player)
	_ambient_hum_player.play()

# ==============================================================================
# AUDIOSTREAMGENERATOR INITIALIZATION (DYNAMIC PROCEDURAL SYNTHESIS)
# ==============================================================================

func _init_generator_player() -> void:
	_generator_player = AudioStreamPlayer.new()
	_generator_player.name = "ProceduralGeneratorPlayer"
	_generator_player.bus = BUS_SFX
	
	var gen := AudioStreamGenerator.new()
	gen.mix_rate = float(MIX_RATE)
	gen.buffer_length = 0.2
	_generator_player.stream = gen
	add_child(_generator_player)
	_generator_player.play()
	_generator_playback = _generator_player.get_stream_playback() as AudioStreamGeneratorPlayback

## Push procedural audio frames into the real-time AudioStreamGenerator buffer
func push_procedural_tone(frequency: float, duration_sec: float, amplitude: float = 0.5) -> void:
	if _generator_playback == null:
		return
	var frames_to_push := int(duration_sec * MIX_RATE)
	var available := _generator_playback.get_frames_available()
	var count := mini(frames_to_push, available)
	
	for i in range(count):
		var t := float(i) / float(MIX_RATE)
		var val := sin(2.0 * PI * frequency * t) * amplitude * exp(-t * 8.0)
		_generator_playback.push_frame(Vector2(val, val))

# ==============================================================================
# GAMEPLAY SFX HELPERS
# ==============================================================================

func play_footstep(pos: Vector3 = Vector3.ZERO) -> void:
	_footstep_alternate = not _footstep_alternate
	var stream: AudioStreamWAV = wav_footstep_1 if _footstep_alternate else wav_footstep_2
	var pitch: float = randf_range(0.94, 1.06)
	
	if pos != Vector3.ZERO:
		play_sfx_3d(stream, pos, -11.0, pitch, 20.0)
	else:
		play_sfx(stream, -11.0, pitch)

func play_mechanical_lever(pos: Vector3 = Vector3.ZERO) -> void:
	var pitch: float = randf_range(0.97, 1.03)
	if pos != Vector3.ZERO:
		play_sfx_3d(wav_lever_clunk, pos, -2.0, pitch, 30.0)
	else:
		play_sfx(wav_lever_clunk, -2.0, pitch)

func play_clue_inspect() -> void:
	var pitch: float = randf_range(0.98, 1.02)
	play_sfx(wav_clue_inspect, -4.0, pitch)

func play_clue_close() -> void:
	var pitch: float = randf_range(0.97, 1.03)
	play_sfx(wav_clue_close, -6.0, pitch)

func play_clock_tick(pos: Vector3 = Vector3.ZERO) -> void:
	_clock_tick_alternate = not _clock_tick_alternate
	var stream: AudioStreamWAV = wav_clock_tick if _clock_tick_alternate else wav_clock_tock
	var pitch: float = randf_range(0.99, 1.01)
	if pos != Vector3.ZERO:
		play_sfx_3d(stream, pos, -14.0, pitch, 15.0)
	else:
		play_sfx(stream, -14.0, pitch)

# ==============================================================================
# BUS VOLUME MANAGEMENT (Standard Decibel / Linear conversion per audio-system)
# ==============================================================================

func set_bus_volume_linear(bus_name: String, linear: float) -> void:
	var idx := AudioServer.get_bus_index(bus_name)
	if idx != -1:
		if linear <= 0.0001:
			AudioServer.set_bus_mute(idx, true)
		else:
			AudioServer.set_bus_mute(idx, false)
			AudioServer.set_bus_volume_db(idx, linear_to_db(linear))

func get_bus_volume_linear(bus_name: String) -> float:
	var idx := AudioServer.get_bus_index(bus_name)
	if idx == -1 or AudioServer.is_bus_mute(idx):
		return 0.0
	return db_to_linear(AudioServer.get_bus_volume_db(idx))

func set_rain_enabled(enabled: bool) -> void:
	if _ambient_rain_player != null:
		_ambient_rain_player.stream_paused = not enabled

func set_hum_enabled(enabled: bool) -> void:
	if _ambient_hum_player != null:
		_ambient_hum_player.stream_paused = not enabled

# ==============================================================================
# PROCEDURAL WAVEFORM SYNTHESIS IMPLEMENTATION
# Pre-synthesizes lightweight 16-bit PCM mono AudioStreamWAV buffers
# ==============================================================================

func _synthesize_all_waveforms() -> void:
	wav_footstep_1 = _synth_concrete_footstep(MIX_RATE, 142.0)
	wav_footstep_2 = _synth_concrete_footstep(MIX_RATE, 128.0)
	wav_lever_clunk = _synth_mechanical_lever_clunk(MIX_RATE)
	wav_clue_inspect = _synth_clue_inspection(MIX_RATE)
	wav_clue_close = _synth_clue_close(MIX_RATE)
	wav_clock_tick = _synth_clock_escapement(MIX_RATE, true)
	wav_clock_tock = _synth_clock_escapement(MIX_RATE, false)
	wav_rain_loop = _synth_seamless_rain_loop(MIX_RATE, 2.5)
	wav_hum_loop = _synth_seamless_hum_loop(MIX_RATE, 3.0)

func _synth_concrete_footstep(rate: int, base_freq: float) -> AudioStreamWAV:
	var duration: float = 0.12 # 120ms
	var samples: int = int(duration * float(rate))
	var bytes := PackedByteArray()
	bytes.resize(samples * 2)
	
	var noise_flt: float = 0.0
	for i in range(samples):
		var t: float = float(i) / float(rate)
		# Rapid frequency pitch drop for sole thud
		var freq: float = base_freq * (1.0 - t * 4.5)
		var thud: float = sin(2.0 * PI * freq * t) * exp(-t * 38.0)
		
		# Gritty concrete texture via single-pole lowpass filtered noise
		var white: float = randf_range(-1.0, 1.0)
		noise_flt = noise_flt * 0.68 + white * 0.32
		var grit: float = noise_flt * exp(-t * 55.0) * 0.55
		
		# High heel/sole click
		var click: float = sin(2.0 * PI * 1650.0 * t) * exp(-t * 85.0) * 0.35
		
		var sample: float = clampf(thud * 0.6 + grit + click, -1.0, 1.0)
		bytes.encode_s16(i * 2, int(sample * 30000.0))
	
	var wav := AudioStreamWAV.new()
	wav.format = AudioStreamWAV.FORMAT_16_BITS
	wav.mix_rate = rate
	wav.stereo = false
	wav.data = bytes
	return wav

func _synth_mechanical_lever_clunk(rate: int) -> AudioStreamWAV:
	var duration: float = 0.40 # 400ms
	var samples: int = int(duration * float(rate))
	var bytes := PackedByteArray()
	bytes.resize(samples * 2)
	
	for i in range(samples):
		var t: float = float(i) / float(rate)
		# Initial spring latch snap (0 to 0.04s)
		var snap: float = 0.0
		if t < 0.05:
			snap = sin(2.0 * PI * 1850.0 * t) * exp(-t * 80.0) * 0.5
		
		# Heavy Grade 30 gray iron body resonance (starts at t = 0.025s)
		var clunk: float = 0.0
		if t >= 0.025:
			var tc: float = t - 0.025
			var fund: float = sin(2.0 * PI * 115.0 * tc)
			var h1: float = sin(2.0 * PI * 245.0 * tc) * 0.42
			var h2: float = sin(2.0 * PI * 490.0 * tc) * 0.22
			clunk = (fund + h1 + h2) * exp(-tc * 13.5) * 0.8
		
		var sample: float = clampf(snap + clunk, -1.0, 1.0)
		bytes.encode_s16(i * 2, int(sample * 31000.0))
	
	var wav := AudioStreamWAV.new()
	wav.format = AudioStreamWAV.FORMAT_16_BITS
	wav.mix_rate = rate
	wav.stereo = false
	wav.data = bytes
	return wav

func _synth_clue_inspection(rate: int) -> AudioStreamWAV:
	var duration: float = 0.48 # 480ms
	var samples: int = int(duration * float(rate))
	var bytes := PackedByteArray()
	bytes.resize(samples * 2)
	
	var n_flt: float = 0.0
	for i in range(samples):
		var t: float = float(i) / float(rate)
		# Archival paper rustle
		var white: float = randf_range(-1.0, 1.0)
		n_flt = n_flt * 0.82 + white * 0.18
		var rustle: float = n_flt * exp(-t * 11.0) * 0.32
		
		# Forensic brass chime triad (D5=587Hz, A5=880Hz, D6=1174Hz)
		var chime1: float = sin(2.0 * PI * 587.33 * t) * 0.4
		var chime2: float = sin(2.0 * PI * 880.0 * t) * 0.35
		var chime3: float = sin(2.0 * PI * 1174.66 * t) * 0.2
		var chime: float = (chime1 + chime2 + chime3) * exp(-t * 6.5)
		
		var sample: float = clampf(rustle + chime, -1.0, 1.0)
		bytes.encode_s16(i * 2, int(sample * 28000.0))
	
	var wav := AudioStreamWAV.new()
	wav.format = AudioStreamWAV.FORMAT_16_BITS
	wav.mix_rate = rate
	wav.stereo = false
	wav.data = bytes
	return wav

func _synth_clue_close(rate: int) -> AudioStreamWAV:
	var duration: float = 0.24 # 240ms
	var samples: int = int(duration * float(rate))
	var bytes := PackedByteArray()
	bytes.resize(samples * 2)
	
	for i in range(samples):
		var t: float = float(i) / float(rate)
		# Damped folio leather/paper thump
		var thump: float = sin(2.0 * PI * 92.0 * t) * exp(-t * 22.0) * 0.72
		var paper: float = randf_range(-0.15, 0.15) * exp(-t * 32.0)
		var sample: float = clampf(thump + paper, -1.0, 1.0)
		bytes.encode_s16(i * 2, int(sample * 28000.0))
	
	var wav := AudioStreamWAV.new()
	wav.format = AudioStreamWAV.FORMAT_16_BITS
	wav.mix_rate = rate
	wav.stereo = false
	wav.data = bytes
	return wav

func _synth_clock_escapement(rate: int, is_tick: bool) -> AudioStreamWAV:
	var duration: float = 0.06 # 60ms
	var samples: int = int(duration * float(rate))
	var bytes := PackedByteArray()
	bytes.resize(samples * 2)
	
	var f1: float = 1420.0 if is_tick else 1160.0
	var f2: float = 710.0 if is_tick else 580.0
	
	for i in range(samples):
		var t: float = float(i) / float(rate)
		var click1: float = sin(2.0 * PI * f1 * t) * 0.6
		var click2: float = sin(2.0 * PI * f2 * t) * 0.4
		var sample: float = clampf((click1 + click2) * exp(-t * 58.0), -1.0, 1.0)
		bytes.encode_s16(i * 2, int(sample * 28000.0))
	
	var wav := AudioStreamWAV.new()
	wav.format = AudioStreamWAV.FORMAT_16_BITS
	wav.mix_rate = rate
	wav.stereo = false
	wav.data = bytes
	return wav

func _synth_seamless_rain_loop(rate: int, duration: float) -> AudioStreamWAV:
	var samples: int = int(duration * float(rate))
	var bytes := PackedByteArray()
	bytes.resize(samples * 2)
	
	var raw_samples := PackedFloat32Array()
	raw_samples.resize(samples)
	
	var flt: float = 0.0
	for i in range(samples):
		var white: float = randf_range(-1.0, 1.0)
		flt = flt * 0.86 + white * 0.14
		raw_samples[i] = flt * 0.42
	
	# Seamless boundary crossfade (50ms)
	var fade_samples: int = int(0.05 * float(rate))
	for i in range(fade_samples):
		var w: float = float(i) / float(fade_samples)
		var end_idx: int = samples - fade_samples + i
		var blended: float = raw_samples[end_idx] * (1.0 - w) + raw_samples[i] * w
		raw_samples[i] = blended
		raw_samples[end_idx] = blended
	
	for i in range(samples):
		var s: float = clampf(raw_samples[i], -1.0, 1.0)
		bytes.encode_s16(i * 2, int(s * 25000.0))
	
	var wav := AudioStreamWAV.new()
	wav.format = AudioStreamWAV.FORMAT_16_BITS
	wav.mix_rate = rate
	wav.stereo = false
	wav.loop_mode = AudioStreamWAV.LOOP_FORWARD
	wav.loop_begin = 0
	wav.loop_end = samples
	wav.data = bytes
	return wav

func _synth_seamless_hum_loop(rate: int, duration: float) -> AudioStreamWAV:
	var samples: int = int(duration * float(rate))
	var bytes := PackedByteArray()
	bytes.resize(samples * 2)
	
	for i in range(samples):
		var t: float = float(i) / float(rate)
		# Exact integer harmonic cycles over loop duration for mathematical continuity
		var h50: float = sin(2.0 * PI * 50.0 * t) * 0.50
		var h100: float = sin(2.0 * PI * 100.0 * t) * 0.24
		var h150: float = sin(2.0 * PI * 150.0 * t) * 0.12
		var h200: float = sin(2.0 * PI * 200.0 * t) * 0.06
		var h25: float = sin(2.0 * PI * 25.0 * t) * 0.28
		var flutter: float = 1.0 + 0.14 * sin(2.0 * PI * 1.0 * t)
		
		var sample: float = clampf((h50 + h100 + h150 + h200 + h25) * flutter * 0.48, -1.0, 1.0)
		bytes.encode_s16(i * 2, int(sample * 26000.0))
	
	var wav := AudioStreamWAV.new()
	wav.format = AudioStreamWAV.FORMAT_16_BITS
	wav.mix_rate = rate
	wav.stereo = false
	wav.loop_mode = AudioStreamWAV.LOOP_FORWARD
	wav.loop_begin = 0
	wav.loop_end = samples
	wav.data = bytes
	return wav
