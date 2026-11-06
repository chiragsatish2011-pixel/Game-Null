extends Control

@onready var label_fps: Label = $PanelContainer/VBoxContainer/LabelFPS
@onready var label_frametime: Label = $PanelContainer/VBoxContainer/LabelFrameTime
@onready var label_draw_calls: Label = $PanelContainer/VBoxContainer/LabelDrawCalls
@onready var label_primitives: Label = $PanelContainer/VBoxContainer/LabelPrimitives
@onready var label_vram: Label = $PanelContainer/VBoxContainer/LabelVRAM
@onready var label_camera_mode: Label = $PanelContainer/VBoxContainer/LabelCameraMode
@onready var label_spring_len: Label = $PanelContainer/VBoxContainer/LabelSpringLen

@onready var prompt_label: Label = $InteractionPrompt/PromptLabel
@onready var inspection_overlay: PanelContainer = $ClueInspectionOverlay
@onready var inspection_text: Label = $ClueInspectionOverlay/MarginContainer/InspectionText

var player: Node = null
var _update_timer: float = 0.0

func _ready() -> void:
	prompt_label.visible = false
	inspection_overlay.visible = false

func connect_player(p: Node) -> void:
	player = p
	if player.has_signal("interaction_prompt_updated") and not player.interaction_prompt_updated.is_connected(_on_interaction_prompt_updated):
		player.interaction_prompt_updated.connect(_on_interaction_prompt_updated)
	if player.has_signal("inspection_state_changed") and not player.inspection_state_changed.is_connected(_on_inspection_state_changed):
		player.inspection_state_changed.connect(_on_inspection_state_changed)

func _process(delta: float) -> void:
	_update_timer += delta
	if _update_timer >= 0.15: # 6.6 Hz update rate to eliminate HUD text render churn
		_update_timer = 0.0
		_update_metrics()

func _update_metrics() -> void:
	var fps: float = Performance.get_monitor(Performance.TIME_FPS)
	var process_time: float = Performance.get_monitor(Performance.TIME_PROCESS) * 1000.0
	var draws: int = int(Performance.get_monitor(Performance.RENDER_TOTAL_DRAW_CALLS_IN_FRAME))
	var prims: int = int(Performance.get_monitor(Performance.RENDER_TOTAL_PRIMITIVES_IN_FRAME))
	var vram_bytes: int = int(Performance.get_monitor(Performance.RENDER_VIDEO_MEM_USED))
	var vram_mb: float = float(vram_bytes) / (1024.0 * 1024.0)
	
	label_fps.text = "FPS: %.1f" % fps
	label_frametime.text = "Frame Time: %.2f ms" % process_time
	label_draw_calls.text = "Draw Calls: %d" % draws
	label_primitives.text = "Primitives: %d tris" % prims
	label_vram.text = "Engine VRAM: %.2f MB" % vram_mb
	
	if player != null:
		var cam_rig: Node = player.get("camera_rig")
		if cam_rig != null:
			var mode_name: String = "UNKNOWN"
			var cur_mode: int = cam_rig.get("current_mode") if "current_mode" in cam_rig else -1
			match cur_mode:
				0: mode_name = "FIRST_PERSON"
				1: mode_name = "THIRD_PERSON"
				2: mode_name = "TRANSITIONING"
				3: mode_name = "INSPECTION"
			label_camera_mode.text = "Camera: %s" % mode_name
			var hits: int = cam_rig.get("compression_event_count") if "compression_event_count" in cam_rig else 0
			var hit_len: float = cam_rig.get("last_hit_length") if "last_hit_length" in cam_rig else 1.8
			label_spring_len.text = "SpringArm: %.2fm (hits: %d)" % [hit_len, hits]

func _on_interaction_prompt_updated(prompt: String, is_visible: bool) -> void:
	prompt_label.text = prompt
	prompt_label.visible = is_visible

func _on_inspection_state_changed(is_inspecting: bool, details: String) -> void:
	inspection_overlay.visible = is_inspecting
	inspection_text.text = details
