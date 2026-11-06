extends Area3D

signal clue_inspected(clue_id: String, clue_description: String)

@export var clue_id: String = "CLUE_TELEGRAPH_01"
@export var prompt_text: String = "[E] Inspect Telegraph Key"
@export var inspection_details: String = "STAMPED BRASS LEVER — SWITCH VAULT 04 SEAL INTACT.\nRelay circuit wired directly to Old Substation switchboard.\nStatus: Mechanically locked. [E or ESC to Close]"

@onready var highlight_mesh: MeshInstance3D = $"../TelegraphKeyMesh"

var _is_player_in_range: bool = false
var _is_currently_inspecting: bool = false

func _ready() -> void:
	# Ensure proper collision setup: Layer 2 for interaction ray/overlap
	collision_layer = 2
	collision_mask = 0
	monitoring = true
	monitorable = true

func can_interact() -> bool:
	return true

func get_prompt() -> String:
	return prompt_text

func interact() -> void:
	_is_currently_inspecting = not _is_currently_inspecting
	if _is_currently_inspecting:
		clue_inspected.emit(clue_id, inspection_details)
	else:
		clue_inspected.emit("", "")

func cancel_inspection() -> void:
	if _is_currently_inspecting:
		_is_currently_inspecting = false
		clue_inspected.emit("", "")
