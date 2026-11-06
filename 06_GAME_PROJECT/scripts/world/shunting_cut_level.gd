# shunting_cut_level.gd
# PROJECT NULL — Level Controller: Shunting Cut (Platform 2)
# Handles environmental puzzle state, turnout mechanics, and culvert access
class_name ShuntingCutLevel
extends Node3D

@export var turnout_shift_duration: float = 0.8
@export var gate_slide_duration: float = 1.4

@onready var tie_rod: Node3D = get_node_or_null("Architecture/TurnoutMechanism/TurnoutTieRod")
@onready var point_blade: Node3D = get_node_or_null("Architecture/TurnoutMechanism/TurnoutPointBlade")
@onready var indicator_disc: Node3D = get_node_or_null("Architecture/TurnoutMechanism/TurnoutIndicatorStand/IndicatorDisc")
@onready var culvert_gate: Node3D = get_node_or_null("Architecture/DrainageCulvertSector02/CulvertGate")
@onready var culvert_lamp: OmniLight3D = get_node_or_null("Architecture/DrainageCulvertSector02/CulvertIndicatorLamp")
@onready var lever_14: LeverInterlocking = get_node_or_null("PlatformProps/PropInterlockingLever14")
@onready var signal_lantern: PropSignalLantern = get_node_or_null("PlatformProps/PropSignalLantern")

const TIE_ROD_NORMAL_X: float = -3.3
const TIE_ROD_PULLED_X: float = -3.15

const POINT_BLADE_NORMAL_X: float = -3.92
const POINT_BLADE_PULLED_X: float = -3.76

const GATE_CLOSED_Y: float = 1.25
const GATE_OPEN_Y: float = 4.0

const COLOR_LAMP_LOCKED := Color(0.85, 0.45, 0.1)
const COLOR_LAMP_CLEARED := Color(0.2, 0.9, 0.35)

var _tie_rod_tween: Tween = null
var _gate_tween: Tween = null

func _ready() -> void:
	# Connect to global decoupled event bus
	EventBus.lever_toggled.connect(_on_lever_toggled)
	EventBus.turnout_switched.connect(_on_turnout_switched)
	
	# Connect directly to lever if present in scene
	if lever_14 != null:
		lever_14.lever_state_changed.connect(_on_lever_state_changed)
	
	# Synchronize world with initial GameState
	if GameState.lever_14_switched:
		_apply_world_state(true, false)
	else:
		_apply_world_state(false, false)

func _on_lever_toggled(lever_id: int, is_pulled: bool) -> void:
	if lever_id == 14:
		_apply_world_state(is_pulled, true)

func _on_turnout_switched(turnout_id: int, is_thrown: bool) -> void:
	if turnout_id == 14:
		_apply_world_state(is_thrown, true)

func _on_lever_state_changed(new_state: LeverInterlocking.LeverState) -> void:
	var is_thrown: bool = (new_state == LeverInterlocking.LeverState.PULLED)
	_apply_world_state(is_thrown, true)

func _apply_world_state(is_thrown: bool, animate: bool) -> void:
	var target_tie_x: float = TIE_ROD_PULLED_X if is_thrown else TIE_ROD_NORMAL_X
	var target_blade_x: float = POINT_BLADE_PULLED_X if is_thrown else POINT_BLADE_NORMAL_X
	var target_rot_y: float = (PI * 0.5) if is_thrown else 0.0
	var target_gate_y: float = GATE_OPEN_Y if is_thrown else GATE_CLOSED_Y
	var target_color: Color = COLOR_LAMP_CLEARED if is_thrown else COLOR_LAMP_LOCKED
	
	if not animate:
		if tie_rod != null:
			tie_rod.position.x = target_tie_x
		if point_blade != null:
			point_blade.position.x = target_blade_x
		if indicator_disc != null:
			indicator_disc.rotation.y = target_rot_y
		if culvert_gate != null:
			culvert_gate.position.y = target_gate_y
		if culvert_lamp != null:
			culvert_lamp.light_color = target_color
		if signal_lantern != null:
			signal_lantern.set_signal(is_thrown)
		return
	
	# 1. Animate Turnout Mechanism (Tie rod, point blade, indicator disc)
	if _tie_rod_tween != null and _tie_rod_tween.is_valid():
		_tie_rod_tween.kill()
	
	_tie_rod_tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	if tie_rod != null:
		_tie_rod_tween.tween_property(tie_rod, "position:x", target_tie_x, turnout_shift_duration)
	if point_blade != null:
		_tie_rod_tween.tween_property(point_blade, "position:x", target_blade_x, turnout_shift_duration)
	if indicator_disc != null:
		_tie_rod_tween.tween_property(indicator_disc, "rotation:y", target_rot_y, turnout_shift_duration)
	
	# 2. Animate Drainage Culvert Gate and Status Indicator
	if _gate_tween != null and _gate_tween.is_valid():
		_gate_tween.kill()
	
	_gate_tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	if culvert_gate != null:
		_gate_tween.tween_property(culvert_gate, "position:y", target_gate_y, gate_slide_duration)
	if culvert_lamp != null:
		_gate_tween.tween_property(culvert_lamp, "light_color", target_color, 0.4)
	if signal_lantern != null:
		signal_lantern.set_signal(is_thrown)
