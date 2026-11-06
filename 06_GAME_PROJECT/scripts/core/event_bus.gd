# event_bus.gd
# PROJECT NULL — Global Decoupled Event Hub
# Invariant: Registered as Autoload singleton "EventBus"
extends Node

# Interaction signals
signal interaction_available(interactable: Node3D, prompt_text: String)
signal interaction_unavailable(interactable: Node3D)
signal interaction_triggered(interactable: Node3D)

# Mechanical & Railway Signals
signal lever_switched(lever_id: String, is_switched: bool)

# Forensic Clue & Examination signals
signal clue_inspected(clue_id: String, clue_data: Dictionary)
signal clue_closed()

# Camera & Player signals
signal camera_mode_changed(is_first_person: bool)
signal player_moved(position: Vector3)

# UI & Dialogue notifications
signal notification_requested(text: String, duration: float)
signal objective_updated(objective_id: String, title: String, description: String)

# Railway Interlocking & Environmental Puzzle signals
signal lever_toggled(lever_id: int, is_pulled: bool)
signal turnout_switched(turnout_id: int, is_thrown: bool)
