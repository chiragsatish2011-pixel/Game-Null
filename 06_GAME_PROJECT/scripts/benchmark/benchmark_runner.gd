extends Node

signal benchmark_warmup_completed()
signal benchmark_finished(summary_data: Dictionary)

@export var warmup_duration_sec: float = 5.0
@export var benchmark_duration_sec: float = 60.0
@export var auto_start: bool = true
@export var auto_quit_on_finish: bool = false
@export var benchmark_id: String = "THIRD_PERSON"

enum BenchmarkState {
	IDLE,
	WARMUP,
	RECORDING,
	COMPLETED
}

var state: BenchmarkState = BenchmarkState.IDLE

# Configuration tracking
var config_id: String = "A"
var run_num: int = 1
var shadow_atlas_size: int = 1024
var shadow_enabled: bool = true
var shadow_max_distance: float = 40.0
var output_dir_override: String = ""

# Warmup tracking
var _warmup_started: bool = false
var _warmup_frames: int = 0
var _warmup_start_usec: int = 0
var _warmup_end_usec: int = 0

# Measurement tracking
var _measurement_start_usec: int = 0
var _measurement_end_usec: int = 0
var _last_frame_usec: int = 0

var _frame_deltas_usec: PackedInt64Array = PackedInt64Array()
var _spike_frames: Array[Dictionary] = [] # Spikes > 42.0ms

var _player_ref: CharacterBody3D = null

func _ready() -> void:
	# Parse command line overrides (both user args and raw cmdline args)
	var args := OS.get_cmdline_user_args()
	for a in OS.get_cmdline_args():
		if not args.has(a):
			args.append(a)
	var i: int = 0
	while i < args.size():
		var arg: String = args[i]
		if arg == "--benchmark-quick":
			warmup_duration_sec = 2.0
			benchmark_duration_sec = 10.0
		elif arg == "--benchmark-duration" and i + 1 < args.size():
			i += 1
			benchmark_duration_sec = float(args[i])
		elif arg == "--warmup-duration" and i + 1 < args.size():
			i += 1
			warmup_duration_sec = float(args[i])
		elif arg == "--benchmark-auto-quit":
			auto_quit_on_finish = true
		elif arg == "--first-person":
			benchmark_id = "FIRST_PERSON"
		elif arg == "--third-person":
			benchmark_id = "THIRD_PERSON"
		elif arg == "--camera-mode" and i + 1 < args.size():
			i += 1
			var mode_arg: String = args[i].to_upper()
			if "FIRST" in mode_arg or mode_arg == "FP":
				benchmark_id = "FIRST_PERSON"
			else:
				benchmark_id = "THIRD_PERSON"
		elif arg == "--config-id" and i + 1 < args.size():
			i += 1
			config_id = args[i].to_upper()
		elif arg == "--run-num" and i + 1 < args.size():
			i += 1
			run_num = int(args[i])
		elif arg == "--borderless":
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN) # Mode 3 (Borderless)
			print("[BENCHMARK CONFIG] Display mode set to BORDERLESS FULLSCREEN (Mode 3)")
		elif arg == "--windowed":
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED) # Mode 0 (Windowed)
			print("[BENCHMARK CONFIG] Display mode set to WINDOWED (Mode 0)")
		elif arg == "--shadow-512":
			shadow_atlas_size = 512
			RenderingServer.directional_shadow_atlas_set_size(512, true)
			print("[BENCHMARK CONFIG] Directional shadow atlas set to 512x512")
		elif arg == "--shadow-1024":
			shadow_atlas_size = 1024
			RenderingServer.directional_shadow_atlas_set_size(1024, true)
			print("[BENCHMARK CONFIG] Directional shadow atlas set to 1024x1024")
		elif arg == "--shadow-disabled":
			shadow_enabled = false
			print("[BENCHMARK CONFIG] Directional shadow explicitly DISABLED")
		elif arg == "--shadow-distance" and i + 1 < args.size():
			i += 1
			shadow_max_distance = float(args[i])
			print("[BENCHMARK CONFIG] Directional shadow distance set to: %.1f m" % shadow_max_distance)
		elif arg == "--output-dir" and i + 1 < args.size():
			i += 1
			output_dir_override = args[i]
		i += 1
	
	if auto_start:
		start_benchmark()

func set_player(p: CharacterBody3D) -> void:
	_player_ref = p

func start_benchmark() -> void:
	state = BenchmarkState.WARMUP
	_warmup_started = false
	_warmup_frames = 0
	print("[BENCHMARK] Entering warm-up state. Awaiting first active rendering frame...")

func _process(_delta: float) -> void:
	var now_usec: int = Time.get_ticks_usec()
	
	if state == BenchmarkState.WARMUP:
		if not _warmup_started:
			_warmup_started = true
			_warmup_start_usec = now_usec
			_last_frame_usec = now_usec
			print("[BENCHMARK] First render frame ticked. Starting %.1fs active rendering warm-up." % warmup_duration_sec)
			return
		
		_warmup_frames += 1
		_last_frame_usec = now_usec
		var elapsed_warmup_sec: float = float(now_usec - _warmup_start_usec) / 1000000.0
		if elapsed_warmup_sec >= warmup_duration_sec:
			_warmup_end_usec = now_usec
			state = BenchmarkState.RECORDING
			_measurement_start_usec = now_usec
			_last_frame_usec = now_usec
			_frame_deltas_usec.clear()
			_spike_frames.clear()
			benchmark_warmup_completed.emit()
			print("[BENCHMARK] Warm-up complete. Discarded %d frames over %.3f s. Commencing measurement recording..." % [_warmup_frames, elapsed_warmup_sec])
		return
	
	elif state == BenchmarkState.RECORDING:
		var frame_delta_usec: int = now_usec - _last_frame_usec
		_last_frame_usec = now_usec
		_frame_deltas_usec.append(frame_delta_usec)
		
		var frame_ms: float = float(frame_delta_usec) / 1000.0
		if frame_ms > 42.0:
			var spike_info: Dictionary = {
				"frame_index": _frame_deltas_usec.size(),
				"delta_ms": frame_ms,
				"timestamp_ms": float(now_usec - _measurement_start_usec) / 1000.0,
				"camera_mode": _get_camera_mode_string()
			}
			_spike_frames.append(spike_info)
			print("[BENCHMARK SPIKE] Frame %d: %.2f ms in mode %s" % [spike_info["frame_index"], frame_ms, spike_info["camera_mode"]])
		
		var elapsed_rec_sec: float = float(now_usec - _measurement_start_usec) / 1000000.0
		if elapsed_rec_sec >= benchmark_duration_sec:
			_measurement_end_usec = now_usec
			state = BenchmarkState.COMPLETED
			_finalize_benchmark()

func _get_camera_mode_string() -> String:
	if _player_ref != null and _player_ref.camera_rig != null:
		match _player_ref.camera_rig.current_mode:
			0: return "FIRST_PERSON"
			1: return "THIRD_PERSON"
			2: return "TRANSITIONING"
			3: return "INSPECTION"
	return "UNKNOWN"

func _finalize_benchmark() -> void:
	var total_frames: int = _frame_deltas_usec.size()
	var total_elapsed_sec: float = float(_measurement_end_usec - _measurement_start_usec) / 1000000.0
	
	if total_frames == 0 or total_elapsed_sec <= 0.0:
		printerr("[BENCHMARK ERROR] Zero frames or invalid elapsed time recorded.")
		return
	
	# Strict sustained FPS calculation
	var sustained_fps: float = float(total_frames) / total_elapsed_sec
	
	# Sort frame deltas ascending
	var sorted_deltas: Array = []
	for d in _frame_deltas_usec:
		sorted_deltas.append(float(d) / 1000.0) # convert to ms
	sorted_deltas.sort()
	
	var idx_p50: int = clampi(int(float(total_frames) * 0.50), 0, total_frames - 1)
	var idx_p95: int = clampi(int(float(total_frames) * 0.95), 0, total_frames - 1)
	var idx_p99: int = clampi(int(float(total_frames) * 0.99), 0, total_frames - 1)
	
	var p50_ms: float = sorted_deltas[idx_p50]
	var p95_ms: float = sorted_deltas[idx_p95]
	var p99_ms: float = sorted_deltas[idx_p99]
	var max_ms: float = sorted_deltas[total_frames - 1]
	
	var vram_bytes: int = int(Performance.get_monitor(Performance.RENDER_VIDEO_MEM_USED))
	var vram_mb: float = float(vram_bytes) / (1024.0 * 1024.0)
	var draw_calls: int = int(Performance.get_monitor(Performance.RENDER_TOTAL_DRAW_CALLS_IN_FRAME))
	var primitives: int = int(Performance.get_monitor(Performance.RENDER_TOTAL_PRIMITIVES_IN_FRAME))
	var current_win_mode: int = DisplayServer.window_get_mode()
	var win_mode_str: String = "FULLSCREEN_BORDERLESS" if current_win_mode == DisplayServer.WINDOW_MODE_FULLSCREEN else ("EXCLUSIVE_FULLSCREEN" if current_win_mode == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN else "WINDOWED")
	
	var summary: Dictionary = {
		"benchmark_id": "M4.1_R1_BENCHMARK",
		"timestamp_utc": Time.get_datetime_string_from_system(true),
		"configuration": {
			"config_id": config_id,
			"repetition": run_num,
			"camera_mode": benchmark_id,
			"window_mode_enum": current_win_mode,
			"window_mode_name": win_mode_str,
			"shadow_atlas_size": shadow_atlas_size,
			"shadow_enabled": shadow_enabled,
			"shadow_max_distance": shadow_max_distance
		},
		"warmup": {
			"duration_target_sec": warmup_duration_sec,
			"actual_duration_sec": float(_warmup_end_usec - _warmup_start_usec) / 1000000.0,
			"discarded_frames": _warmup_frames
		},
		"measurement": {
			"duration_target_sec": benchmark_duration_sec,
			"actual_duration_sec": total_elapsed_sec,
			"total_rendered_frames": total_frames,
			"sustained_fps": sustained_fps,
			"percentiles_ms": {
				"p50": p50_ms,
				"p95": p95_ms,
				"p99": p99_ms,
				"max": max_ms
			},
			"spikes_over_42ms_count": _spike_frames.size(),
			"spikes_log": _spike_frames
		},
		"engine_metrics": {
			"render_video_mem_mb": vram_mb,
			"draw_calls": draw_calls,
			"primitives": primitives
		},
		"acceptance_evaluation": {
			"p50_pass": p50_ms <= 33.33,
			"p95_pass": p95_ms <= 36.00,
			"p99_pass": p99_ms <= 42.00,
			"sustained_fps_pass": sustained_fps >= 30.0,
			"overall_tier_2_pass": (p50_ms <= 33.33 and p95_ms <= 36.00 and p99_ms <= 42.00 and sustained_fps >= 30.0)
		}
	}
	
	print("\n==================================================================")
	print("PROJECT NULL — M4.1-R1 BENCHMARK EXECUTION RESULTS")
	print("==================================================================")
	print("Config ID / Repetition   : Config %s | Run %d" % [config_id, run_num])
	print("Camera Mode / Display    : %s | %s" % [benchmark_id, win_mode_str])
	print("Directional Shadow Size  : %d x %d" % [shadow_atlas_size, shadow_atlas_size])
	print("Warm-up Discarded Frames : %d (over %.2f s active rendering)" % [_warmup_frames, summary["warmup"]["actual_duration_sec"]])
	print("Total Measured Frames    : %d" % total_frames)
	print("Elapsed Measurement Time : %.2f s" % total_elapsed_sec)
	print("Sustained Framerate      : %.2f FPS" % sustained_fps)
	print("Median Frame Time (P50)  : %.2f ms (Threshold: <= 33.33 ms)" % p50_ms)
	print("95th Percentile (P95)    : %.2f ms (Threshold: <= 36.00 ms)" % p95_ms)
	print("99th Percentile (P99)    : %.2f ms (Threshold: <= 42.00 ms)" % p99_ms)
	print("Maximum Frame Time (Max) : %.2f ms" % max_ms)
	print("Spikes Over 42.0 ms      : %d" % _spike_frames.size())
	print("Engine Video Memory      : %.2f MB (Budget: <= 500 MB)" % vram_mb)
	print("Draw Calls               : %d (Ceiling: <= 220)" % draw_calls)
	print("Primitives               : %d triangles" % primitives)
	print("Tier 2 Acceptance Result : %s" % ("PASS" if summary["acceptance_evaluation"]["overall_tier_2_pass"] else "FAIL"))
	print("==================================================================\n")
	
	_export_telemetry_artifacts(summary)
	benchmark_finished.emit(summary)
	
	if auto_quit_on_finish:
		get_tree().quit(0 if summary["acceptance_evaluation"]["overall_tier_2_pass"] else 1)

func _export_telemetry_artifacts(summary: Dictionary) -> void:
	var base_path: String = ProjectSettings.globalize_path("res://")
	var target_dir: String
	if output_dir_override != "":
		if output_dir_override.is_absolute_path():
			target_dir = output_dir_override
		else:
			target_dir = base_path.path_join(output_dir_override).simplify_path()
	else:
		target_dir = base_path.path_join("../08_TESTING/telemetry").simplify_path()
	
	DirAccess.make_dir_recursive_absolute(target_dir)
	
	# Determine file naming: if config_id is populated, use structured name
	var file_stem: String = "m4_1_r1_config_%s_%s_run%d" % [config_id.to_lower(), benchmark_id.to_lower(), run_num]
	
	# 1. Export JSON Summary
	var json_str := JSON.stringify(summary, "\t")
	var json_path: String = target_dir.path_join(file_stem + ".json")
	var file_json := FileAccess.open(json_path, FileAccess.WRITE)
	if file_json != null:
		file_json.store_string(json_str)
		file_json.close()
		print("[BENCHMARK] Saved summary to: %s" % json_path)
	
	# 2. Export Raw Frametimes CSV
	var csv_path: String = target_dir.path_join(file_stem + ".csv")
	var file_csv := FileAccess.open(csv_path, FileAccess.WRITE)
	if file_csv != null:
		file_csv.store_line("frame_index,delta_ms")
		for i in range(_frame_deltas_usec.size()):
			var ms: float = float(_frame_deltas_usec[i]) / 1000.0
			file_csv.store_line("%d,%.3f" % [i + 1, ms])
		file_csv.close()
		print("[BENCHMARK] Saved raw frame deltas to: %s" % csv_path)
