# prop_interlocking_lever.gd
# PROJECT NULL — Mechanical Turnout & Interlocking Lever Controller
class_name PropInterlockingLever
extends StaticBody3D

@export var lever_id: String = "lever_14"

@onready var lever_mesh: MeshInstance3D = $LeverMesh
@onready var interactable_area: InteractableProp = $InteractableArea

var is_pulled: bool = false

func _ready() -> void:
	if interactable_area:
		interactable_area.prompt_text = "[E] Pull Signal Lever #14"
	
	EventBus.clue_inspected.connect(_on_clue_inspected)
	
	# Synchronize with initial GameState
	if GameState.lever_14_switched:
		is_pulled = true
		_set_lever_visual(true, false)

func _exit_tree() -> void:
	if EventBus.clue_inspected.is_connected(_on_clue_inspected):
		EventBus.clue_inspected.disconnect(_on_clue_inspected)

func _on_clue_inspected(clue_identifier: String, _data: Dictionary) -> void:
	if clue_identifier == "prop_interlocking_lever_14":
		toggle_lever()

func toggle_lever() -> void:
	is_pulled = !is_pulled
	GameState.lever_14_switched = is_pulled
	_set_lever_visual(is_pulled, true)
	EventBus.lever_switched.emit(lever_id, is_pulled)
	
	if is_pulled:
		EventBus.notification_requested.emit("Lever #14 Thrown — Shunting Turnout Points Cleared (Line Open)", 3.5)
	else:
		EventBus.notification_requested.emit("Lever #14 Reset — Shunting Turnout Points Locked (Danger)", 3.0)

func _set_lever_visual(pulled: bool, animate: bool) -> void:
	if not lever_mesh:
		return
	# Default locked angle: X rot -15 deg (-0.2618 rad), pulled: +15 deg (+0.2618 rad)
	var target_rot_x: float = deg_to_rad(15.0) if pulled else deg_to_rad(-15.0)
	var target_pos_z: float = 0.1 if pulled else -0.1
	
	if animate:
		var tween := create_tween().set_parallel(true).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		tween.tween_property(lever_mesh, "rotation:x", target_rot_x, 0.4)
		tween.tween_property(lever_mesh, "position:z", target_pos_z, 0.4)
	else:
		lever_mesh.rotation.x = target_rot_x
		lever_mesh.position.z = target_pos_z
