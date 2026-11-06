# prop_signal_lantern.gd
# PROJECT NULL — Railway Shunting Cut Signal Lantern
# Target Engine: Godot 4.7.2 Stable (gl_compatibility / OpenGL 3.3)
# Invariant: Decoupled EventBus listener, 0 Point Light Shadows
class_name PropSignalLantern
extends Node3D

@export var is_clear: bool = false:
	set(value):
		set_signal(value)
	get:
		return _is_clear

@export var linked_lever_id: int = 14

@onready var lens_upper_red: MeshInstance3D = $Housing/LensUpperRed
@onready var lens_lower_green: MeshInstance3D = $Housing/LensLowerGreen
@onready var signal_light: OmniLight3D = $Housing/SignalLight

var _is_clear: bool = false
var _mat_red: StandardMaterial3D
var _mat_green: StandardMaterial3D

# Low-emission values compliant with low-VRAM gl_compatibility baseline
const COLOR_RED_ON := Color(0.95, 0.15, 0.12)
const COLOR_RED_OFF := Color(0.25, 0.04, 0.04)
const COLOR_GREEN_ON := Color(0.12, 0.95, 0.38)
const COLOR_GREEN_OFF := Color(0.03, 0.22, 0.08)

func _ready() -> void:
	# Duplicate materials per-instance to prevent sharing material state across different lanterns
	if lens_upper_red:
		var base_red := lens_upper_red.get_active_material(0)
		if base_red is StandardMaterial3D:
			_mat_red = base_red.duplicate()
		else:
			_mat_red = StandardMaterial3D.new()
			_mat_red.roughness = 0.3
		lens_upper_red.material_override = _mat_red
	
	if lens_lower_green:
		var base_green := lens_lower_green.get_active_material(0)
		if base_green is StandardMaterial3D:
			_mat_green = base_green.duplicate()
		else:
			_mat_green = StandardMaterial3D.new()
			_mat_green.roughness = 0.3
		lens_lower_green.material_override = _mat_green

	# Decoupled EventBus listeners
	if EventBus.has_signal("lever_toggled"):
		EventBus.lever_toggled.connect(_on_lever_toggled)
	if EventBus.has_signal("turnout_switched"):
		EventBus.turnout_switched.connect(_on_turnout_switched)
	if EventBus.has_signal("lever_switched"):
		EventBus.lever_switched.connect(_on_lever_switched)

	# Initialize state matching current GameState
	if "lever_14_switched" in GameState and GameState.lever_14_switched:
		set_signal(true)
	else:
		set_signal(_is_clear)

func _exit_tree() -> void:
	if EventBus.has_signal("lever_toggled") and EventBus.lever_toggled.is_connected(_on_lever_toggled):
		EventBus.lever_toggled.disconnect(_on_lever_toggled)
	if EventBus.has_signal("turnout_switched") and EventBus.turnout_switched.is_connected(_on_turnout_switched):
		EventBus.turnout_switched.disconnect(_on_turnout_switched)
	if EventBus.has_signal("lever_switched") and EventBus.lever_switched.is_connected(_on_lever_switched):
		EventBus.lever_switched.disconnect(_on_lever_switched)

func _on_lever_toggled(id: int, is_pulled: bool) -> void:
	if id == linked_lever_id:
		set_signal(is_pulled)

func _on_turnout_switched(id: int, is_thrown: bool) -> void:
	if id == linked_lever_id:
		set_signal(is_thrown)

func _on_lever_switched(id: String, is_switched: bool) -> void:
	if id == str(linked_lever_id) or id == ("lever_" + str(linked_lever_id)):
		set_signal(is_switched)

func set_signal(clear_signal: bool) -> void:
	_is_clear = clear_signal
	if _mat_red == null or _mat_green == null:
		return

	if _is_clear:
		# Green lens ACTIVE (Line Clear / Branch Route Aligned)
		_mat_red.albedo_color = COLOR_RED_OFF
		_mat_red.emission_enabled = false
		_mat_red.emission_energy_multiplier = 0.0

		_mat_green.albedo_color = COLOR_GREEN_ON
		_mat_green.emission_enabled = true
		_mat_green.emission = COLOR_GREEN_ON
		_mat_green.emission_energy_multiplier = 1.6

		if signal_light:
			signal_light.light_color = COLOR_GREEN_ON
			signal_light.position.y = 0.32
			signal_light.light_energy = 0.5
	else:
		# Red lens ACTIVE (Danger / Shunting Turnout Locked)
		_mat_red.albedo_color = COLOR_RED_ON
		_mat_red.emission_enabled = true
		_mat_red.emission = COLOR_RED_ON
		_mat_red.emission_energy_multiplier = 1.6

		_mat_green.albedo_color = COLOR_GREEN_OFF
		_mat_green.emission_enabled = false
		_mat_green.emission_energy_multiplier = 0.0

		if signal_light:
			signal_light.light_color = COLOR_RED_ON
			signal_light.position.y = 0.52
			signal_light.light_energy = 0.5
