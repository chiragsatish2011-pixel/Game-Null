# hud_gameplay.gd
# PROJECT NULL — Production In-Game HUD & Clue Examination Controller
class_name HUDGameplay
extends CanvasLayer

@onready var prompt_label: Label = $SafeMargin/PromptContainer/PromptLabel
@onready var notification_label: Label = $SafeMargin/NotificationContainer/NotificationLabel
@onready var objective_title: Label = $SafeMargin/ObjectiveBox/ObjectiveTitle
@onready var objective_desc: Label = $SafeMargin/ObjectiveBox/ObjectiveDesc

@onready var exam_panel: PanelContainer = $ExaminationOverlay
@onready var exam_title: Label = $ExaminationOverlay/Margin/VBox/ExamTitle
@onready var exam_desc: Label = $ExaminationOverlay/Margin/VBox/ContentHBox/DetailsVBox/ExamDesc
@onready var exam_notes: Label = $ExaminationOverlay/Margin/VBox/ContentHBox/DetailsVBox/ExamNotes
@onready var clue_inspection_3d: ClueInspection3D = $ExaminationOverlay/Margin/VBox/ContentHBox/PreviewVBox/PreviewFrame/ClueInspection3D

const CLUE_SCENE_MAP: Dictionary = {
	"clue_black_registry": "res://scenes/props/clue_black_registry.tscn",
	"clue_embossing_seal_press": "res://scenes/props/clue_embossing_seal_press.tscn",
	"prop_interlocking_lever_14": "res://scenes/props/prop_interlocking_lever_14.tscn",
	"prop_regulator_clock": "res://scenes/props/prop_regulator_clock.tscn",
	"CLUE_TELEGRAPH_01": "res://scenes/poc/clue_telegraph_prop.tscn"
}

var _current_interactable: Node3D = null
var _notification_timer: float = 0.0
var _cached_clue_instances: Dictionary = {}

func _ready() -> void:
	layer = 10
	prompt_label.visible = false
	notification_label.visible = false
	exam_panel.visible = false
	
	# Fallback node resolutions in case scene hierarchy varies
	if not exam_desc:
		exam_desc = find_child("ExamDesc", true, false)
	if not exam_notes:
		exam_notes = find_child("ExamNotes", true, false)
	if not clue_inspection_3d:
		clue_inspection_3d = find_child("ClueInspection3D", true, false)
	
	EventBus.interaction_available.connect(_on_interaction_available)
	EventBus.interaction_unavailable.connect(_on_interaction_unavailable)
	EventBus.clue_inspected.connect(_on_clue_inspected)
	EventBus.clue_closed.connect(_on_clue_closed_external)
	EventBus.notification_requested.connect(_on_notification_requested)
	EventBus.objective_updated.connect(_on_objective_updated)
	
	# Initial objective display
	objective_title.text = GameState.current_objective_title
	objective_desc.text = GameState.current_objective_desc

func _process(delta: float) -> void:
	if _notification_timer > 0.0:
		_notification_timer -= delta
		if _notification_timer <= 0.0:
			notification_label.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if exam_panel.visible:
		if event.is_action_pressed("interact") or event.is_action_pressed("ui_cancel"):
			close_examination()
			get_viewport().set_input_as_handled()

func _on_interaction_available(interactable: Node3D, prompt_text: String) -> void:
	if exam_panel.visible:
		return
	_current_interactable = interactable
	prompt_label.text = prompt_text
	prompt_label.visible = true

func _on_interaction_unavailable(interactable: Node3D) -> void:
	if _current_interactable == interactable:
		_current_interactable = null
		prompt_label.visible = false

func _on_clue_inspected(clue_id: String, clue_data: Dictionary) -> void:
	prompt_label.visible = false
	exam_title.text = str(clue_data.get("title", "ARCHIVAL CLUE")).to_upper()
	exam_desc.text = str(clue_data.get("description", ""))
	exam_notes.text = "FORENSIC ASSESSMENT:\n" + str(clue_data.get("notes", "No additional physical anomalies recorded."))
	exam_panel.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	# Feed visual representation to the 3D inspection viewport
	var visual_target: Node3D = _resolve_clue_visual(clue_id, clue_data)
	if is_instance_valid(clue_inspection_3d):
		clue_inspection_3d.display_clue(visual_target)

func _resolve_clue_visual(clue_id: String, clue_data: Dictionary) -> Node3D:
	if clue_data.has("mesh_node") and clue_data["mesh_node"] is Node3D:
		return clue_data["mesh_node"]
	
	if clue_data.has("target_mesh") and clue_data["target_mesh"] is Node3D:
		return clue_data["target_mesh"]
	
	if clue_data.has("source_node") and clue_data["source_node"] is Node3D:
		var src: Node3D = clue_data["source_node"]
		if src.get_parent() is Node3D and not (src.get_parent() is SubViewport or src.get_parent() is CanvasLayer):
			return src.get_parent()
		return src
	
	if is_instance_valid(_current_interactable):
		if _current_interactable.get_parent() is Node3D and not (_current_interactable.get_parent() is SubViewport or _current_interactable.get_parent() is CanvasLayer):
			return _current_interactable.get_parent()
		return _current_interactable
	
	if CLUE_SCENE_MAP.has(clue_id):
		if not _cached_clue_instances.has(clue_id):
			var packed: PackedScene = load(CLUE_SCENE_MAP[clue_id]) as PackedScene
			if packed:
				_cached_clue_instances[clue_id] = packed.instantiate()
		if _cached_clue_instances.has(clue_id):
			return _cached_clue_instances[clue_id]
	
	return null

func close_examination() -> void:
	exam_panel.visible = false
	if is_instance_valid(clue_inspection_3d):
		clue_inspection_3d.clear()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	EventBus.clue_closed.emit()
	if _current_interactable:
		prompt_label.visible = true

func _on_clue_closed_external() -> void:
	if exam_panel.visible:
		exam_panel.visible = false
		if is_instance_valid(clue_inspection_3d):
			clue_inspection_3d.clear()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		if _current_interactable:
			prompt_label.visible = true

func _on_notification_requested(text: String, duration: float) -> void:
	notification_label.text = text
	notification_label.visible = true
	_notification_timer = duration

func _on_objective_updated(_id: String, title: String, desc: String) -> void:
	objective_title.text = title
	objective_desc.text = desc

func _exit_tree() -> void:
	for inst in _cached_clue_instances.values():
		if is_instance_valid(inst):
			inst.queue_free()
	_cached_clue_instances.clear()
