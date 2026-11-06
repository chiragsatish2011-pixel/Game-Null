# lever_interlocking.gd
# PROJECT NULL — Mechanical Interlocking Railway Signal Lever Component
# Architecture: Enum-based FSM with decoupled EventBus integration
class_name LeverInterlocking
extends StaticBody3D

enum LeverState {
	NORMAL,
	PULLED
}

signal lever_state_changed(new_state: LeverState)
signal lever_thrown()
signal lever_reset()

@export var lever_id: int = 14
@export var current_state: LeverState = LeverState.NORMAL
@export var normal_angle_deg: float = -15.0
@export var pulled_angle_deg: float = 25.0
@export var animation_duration: float = 0.6
@export var allow_toggle: bool = true
@export var is_interactable: bool = true

@onready var lever_mesh: Node3D = ($LeverPivot if has_node("LeverPivot") else get_node_or_null("LeverMesh"))
@onready var interactable_area: Area3D = $InteractableArea

var _is_animating: bool = false
var _is_focused: bool = false
var _active_tween: Tween = null

func _ready() -> void:
	# Synchronize visual rotation with initial state
	var target_deg: float = pulled_angle_deg if current_state == LeverState.PULLED else normal_angle_deg
	if lever_mesh != null:
		lever_mesh.rotation.x = deg_to_rad(target_deg)

func _get_event_bus() -> Node:
	if has_node("/root/EventBus"):
		return get_node("/root/EventBus")
	return null

func _get_game_state() -> Node:
	if has_node("/root/GameState"):
		return get_node("/root/GameState")
	return null

func get_prompt() -> String:
	if current_state == LeverState.NORMAL:
		return "[E] Throw Signal Lever #%d" % lever_id
	else:
		return ("[E] Reset Signal Lever #%d to Normal" % lever_id) if allow_toggle else ("Signal Lever #%d (Turnout Aligned)" % lever_id)

func set_focus(focused: bool) -> void:
	if not is_interactable:
		return
	if _is_focused == focused:
		return
	_is_focused = focused
	var bus := _get_event_bus()
	if bus:
		if _is_focused:
			bus.interaction_available.emit(self, get_prompt())
		else:
			bus.interaction_unavailable.emit(self)

func interact() -> void:
	if not is_interactable or _is_animating:
		return
	
	if current_state == LeverState.NORMAL:
		pull_lever()
	elif allow_toggle:
		reset_lever()
	else:
		var bus := _get_event_bus()
		if bus:
			bus.notification_requested.emit("LEVER %d MECHANICALLY INTERLOCKED // LOCKED IN REVERSE" % lever_id, 2.5)

func pull_lever() -> void:
	if current_state == LeverState.PULLED or _is_animating:
		return
	
	_is_animating = true
	current_state = LeverState.PULLED
	
	# 1. Update narrative and forensic GameState
	var gs := _get_game_state()
	if gs:
		gs.lever_14_switched = true
		gs.current_objective_title = "Platform 2 Clearance Granted"
		gs.current_objective_desc = "Track turnout aligned. Access to Drainage Culvert Sector 02 is now open."
	
	# 2. Animate lever handle tilt via Tween (-15 deg -> +25 deg)
	if _active_tween != null and _active_tween.is_valid():
		_active_tween.kill()
	
	_active_tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	_active_tween.tween_property(lever_mesh, "rotation:x", deg_to_rad(pulled_angle_deg), animation_duration)
	_active_tween.tween_callback(func(): _is_animating = false)
	
	# 3. Emit decoupled notifications and signals via EventBus
	var bus := _get_event_bus()
	if bus:
		bus.notification_requested.emit("TURNOUT 14 THROWN // EASTERN TRACK SWITCH ENGAGED", 4.0)
		if gs:
			bus.objective_updated.emit(
				gs.current_objective_id,
				gs.current_objective_title,
				gs.current_objective_desc
			)
		bus.lever_toggled.emit(lever_id, true)
		bus.turnout_switched.emit(lever_id, true)
	
	# 4. Local signals
	lever_state_changed.emit(LeverState.PULLED)
	lever_thrown.emit()
	
	# Refresh prompt if player is still focusing
	if _is_focused and bus:
		bus.interaction_available.emit(self, get_prompt())

func reset_lever() -> void:
	if current_state == LeverState.NORMAL or _is_animating:
		return
	
	_is_animating = true
	current_state = LeverState.NORMAL
	
	# 1. Update GameState
	var gs := _get_game_state()
	if gs:
		gs.lever_14_switched = false
	
	# 2. Animate lever handle tilt back (+25 deg -> -15 deg)
	if _active_tween != null and _active_tween.is_valid():
		_active_tween.kill()
	
	_active_tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	_active_tween.tween_property(lever_mesh, "rotation:x", deg_to_rad(normal_angle_deg), animation_duration)
	_active_tween.tween_callback(func(): _is_animating = false)
	
	# 3. Emit decoupled notifications and signals via EventBus
	var bus := _get_event_bus()
	if bus:
		bus.notification_requested.emit("TURNOUT 14 RESET // MAIN LINE ALIGNED", 3.5)
		bus.lever_toggled.emit(lever_id, false)
		bus.turnout_switched.emit(lever_id, false)
	
	# 4. Local signals
	lever_state_changed.emit(LeverState.NORMAL)
	lever_reset.emit()
	
	# Refresh prompt if player is still focusing
	if _is_focused and bus:
		bus.interaction_available.emit(self, get_prompt())
