# lever_interactable_area.gd
# PROJECT NULL — Collision Proxy for Lever Interaction
class_name LeverInteractableArea
extends Area3D

var is_inspection_prop: bool = false

signal clue_inspected(clue_id: String, clue_description: String)

func _ready() -> void:
	collision_layer = 2
	collision_mask = 0

func get_prompt() -> String:
	var parent := get_parent()
	if parent != null and parent.has_method("get_prompt"):
		return parent.get_prompt()
	return "[E] Throw Signal Lever #14"

func set_focus(focused: bool) -> void:
	var parent := get_parent()
	if parent != null and parent.has_method("set_focus"):
		parent.set_focus(focused)

func interact() -> void:
	var parent := get_parent()
	if parent != null and parent.has_method("interact"):
		parent.interact()
	# Dismiss any potential inspection state in player controller immediately
	clue_inspected.emit.call_deferred("", "")

func cancel_inspection() -> void:
	var parent := get_parent()
	if parent != null and parent.has_method("cancel_inspection"):
		parent.cancel_inspection()
