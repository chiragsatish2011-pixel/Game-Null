# interactable_prop.gd
# PROJECT NULL — Reusable Forensic Interaction Component
class_name InteractableProp
extends Area3D

@export var prompt_text: String = "Press [E] to Inspect"
@export var clue_id: String = ""
@export var clue_title: String = "Unknown Artifact"
@export_multiline var clue_description: String = ""
@export_multiline var clue_forensic_notes: String = ""
@export var is_interactable: bool = true

# Optional mesh to highlight on focus
@export var target_mesh: GeometryInstance3D

var _is_focused: bool = false

func _ready() -> void:
	# Interaction layer 2
	collision_layer = 2
	collision_mask = 0

func get_prompt() -> String:
	return prompt_text

func set_focus(focused: bool) -> void:
	if not is_interactable:
		return
	if _is_focused == focused:
		return
	_is_focused = focused
	if _is_focused:
		EventBus.interaction_available.emit(self, prompt_text)
	else:
		EventBus.interaction_unavailable.emit(self)

func interact() -> void:
	if not is_interactable:
		return
	
	EventBus.interaction_triggered.emit(self)
	
	if clue_id != "":
		var clue_data: Dictionary = {
			"id": clue_id,
			"title": clue_title,
			"description": clue_description,
			"notes": clue_forensic_notes,
			"source_node": self,
			"target_mesh": target_mesh
		}
		EventBus.clue_inspected.emit(clue_id, clue_data)

func cancel_inspection() -> void:
	EventBus.clue_closed.emit()
