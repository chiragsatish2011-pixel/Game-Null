# game_state.gd
# PROJECT NULL — Global Narrative & Forensic Game State Manager
# Invariant: Registered as Autoload singleton "GameState"
extends Node

# Dictionary of discovered clue IDs to inspection timestamp and metadata
var discovered_clues: Dictionary = {}

# Current active objective
var current_objective_id: String = "vesper_01_shunting_investigation"
var current_objective_title: String = "Vesper Shunting Cut — Platform 2"
var current_objective_desc: String = "Locate the Yard Master's Black Registry in the Signal Office."

# Flags for environmental mechanical states
var lever_14_switched: bool = false
var yard_office_unlocked: bool = true
var is_examining_clue: bool = false

func _ready() -> void:
	EventBus.clue_inspected.connect(_on_clue_inspected)
	EventBus.clue_closed.connect(_on_clue_closed)

func _on_clue_inspected(clue_id: String, clue_data: Dictionary) -> void:
	is_examining_clue = true
	if not discovered_clues.has(clue_id):
		discovered_clues[clue_id] = {
			"data": clue_data,
			"timestamp": Time.get_unix_time_from_system()
		}
		EventBus.notification_requested.emit("New Evidence Discovered: " + str(clue_data.get("title", clue_id)), 3.5)

func _on_clue_closed() -> void:
	is_examining_clue = false

func is_clue_discovered(clue_id: String) -> bool:
	return discovered_clues.has(clue_id)
