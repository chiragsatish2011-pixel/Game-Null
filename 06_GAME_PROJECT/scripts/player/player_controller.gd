extends CharacterBody3D

signal interaction_prompt_updated(prompt: String, visible: bool)
signal inspection_state_changed(is_inspecting: bool, details: String)

@export var walk_speed: float = 2.4
@export var acceleration: float = 8.0
@export var friction: float = 10.0
@export var gravity: float = 9.8

@onready var camera_rig: Node3D = $CameraDualRig
@onready var mannequin_visual: Node3D = $MannequinVisual
@onready var interaction_ray: RayCast3D = $InteractionRay

# Procedural limb pivots
@onready var left_arm_pivot: Node3D = $MannequinVisual/LeftArmPivot
@onready var right_arm_pivot: Node3D = $MannequinVisual/RightArmPivot
@onready var left_leg_pivot: Node3D = $MannequinVisual/LeftLegPivot
@onready var right_leg_pivot: Node3D = $MannequinVisual/RightLegPivot

var _is_inspecting: bool = false
var _current_interactable: Area3D = null
var _walk_cycle_phase: float = 0.0

# Scripted test simulation hooks
var simulated_input_vec: Vector2 = Vector2.ZERO

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		camera_rig.handle_mouse_look(event.relative, self)
	
	if event.is_action_pressed("toggle_camera"):
		camera_rig.toggle_mode()
	
	if event.is_action_pressed("interact"):
		_handle_interaction()
	
	if event.is_action_pressed("ui_cancel"):
		if _is_inspecting:
			_cancel_inspection()
		else:
			if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			else:
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y = 0.0
	
	if _is_inspecting:
		velocity.x = move_toward(velocity.x, 0.0, friction * delta)
		velocity.z = move_toward(velocity.z, 0.0, friction * delta)
		move_and_slide()
		return
	
	# Movement input
	var input_vec: Vector2 = simulated_input_vec if simulated_input_vec != Vector2.ZERO else Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var move_dir: Vector3 = Vector3.ZERO
	
	if input_vec != Vector2.ZERO:
		# Calculate direction relative to camera yaw
		var cam_yaw: float = camera_rig.camera.global_transform.basis.get_euler().y
		var basis_rot := Basis(Vector3.UP, cam_yaw)
		move_dir = (basis_rot * Vector3(input_vec.x, 0, input_vec.y)).normalized()
		
		velocity.x = move_toward(velocity.x, move_dir.x * walk_speed, acceleration * delta)
		velocity.z = move_toward(velocity.z, move_dir.z * walk_speed, acceleration * delta)
		
		# Rotate visual mannequin toward movement direction in 3rd person
		if camera_rig.current_mode == camera_rig.CameraMode.THIRD_PERSON:
			var target_rot: float = atan2(move_dir.x, move_dir.z)
			mannequin_visual.rotation.y = lerp_angle(mannequin_visual.rotation.y, target_rot, 10.0 * delta)
	else:
		velocity.x = move_toward(velocity.x, 0.0, friction * delta)
		velocity.z = move_toward(velocity.z, 0.0, friction * delta)
	
	move_and_slide()
	
	# Emit movement signal for footstep cadence
	if is_on_floor() and Vector2(velocity.x, velocity.z).length() > 0.1:
		EventBus.player_moved.emit(global_position)
	
	# Procedural kinematics
	_animate_procedural_walk(delta, input_vec.length())
	
	# Interaction ray detection
	_check_interaction_ray()

func _animate_procedural_walk(delta: float, input_magnitude: float) -> void:
	var horiz_speed: float = Vector2(velocity.x, velocity.z).length()
	if horiz_speed > 0.1 and input_magnitude > 0.0:
		_walk_cycle_phase += horiz_speed * 6.0 * delta
		var arm_swing: float = sin(_walk_cycle_phase) * 0.4
		var leg_swing: float = sin(_walk_cycle_phase) * 0.45
		
		left_arm_pivot.rotation.x = arm_swing
		right_arm_pivot.rotation.x = -arm_swing
		left_leg_pivot.rotation.x = -leg_swing
		right_leg_pivot.rotation.x = leg_swing
	else:
		# Reset to rest
		left_arm_pivot.rotation.x = lerp(left_arm_pivot.rotation.x, 0.0, 8.0 * delta)
		right_arm_pivot.rotation.x = lerp(right_arm_pivot.rotation.x, 0.0, 8.0 * delta)
		left_leg_pivot.rotation.x = lerp(left_leg_pivot.rotation.x, 0.0, 8.0 * delta)
		right_leg_pivot.rotation.x = lerp(right_leg_pivot.rotation.x, 0.0, 8.0 * delta)

func _check_interaction_ray() -> void:
	if interaction_ray.is_colliding():
		var collider: Object = interaction_ray.get_collider()
		if collider is Area3D and collider.has_method("get_prompt"):
			if _current_interactable != collider:
				if _current_interactable != null and _current_interactable.has_method("set_focus"):
					_current_interactable.set_focus(false)
				_current_interactable = collider
				if _current_interactable.has_method("set_focus"):
					_current_interactable.set_focus(true)
			interaction_prompt_updated.emit(collider.get_prompt(), true)
			return
	
	if _current_interactable != null:
		if _current_interactable.has_method("set_focus"):
			_current_interactable.set_focus(false)
		_current_interactable = null
		interaction_prompt_updated.emit("", false)

func _handle_interaction() -> void:
	if _is_inspecting:
		_cancel_inspection()
		return
	
	if _current_interactable != null and _current_interactable.has_method("interact"):
		var opens_inspection: bool = true
		if "is_inspection_prop" in _current_interactable and not _current_interactable.is_inspection_prop:
			opens_inspection = false
		elif _current_interactable.has_method("is_inspection_prop") and not _current_interactable.is_inspection_prop():
			opens_inspection = false
		
		if opens_inspection:
			_is_inspecting = true
			_current_interactable.interact()
			# Connect to signal if available
			if _current_interactable.has_signal("clue_inspected") and not _current_interactable.clue_inspected.is_connected(_on_clue_inspected):
				_current_interactable.clue_inspected.connect(_on_clue_inspected)
			
			var anchor: Marker3D = _current_interactable.get_node_or_null("../InspectionAnchor")
			if anchor != null:
				camera_rig.enter_inspection(anchor.global_transform)
		else:
			_current_interactable.interact()

func _on_clue_inspected(_clue_id: String, clue_description: String) -> void:
	if clue_description != "":
		inspection_state_changed.emit(true, clue_description)
	else:
		_cancel_inspection()

func _cancel_inspection() -> void:
	_is_inspecting = false
	if _current_interactable != null and _current_interactable.has_method("cancel_inspection"):
		_current_interactable.cancel_inspection()
	camera_rig.exit_inspection()
	inspection_state_changed.emit(false, "")

func trigger_interaction() -> void:
	_handle_interaction()

func cancel_inspection() -> void:
	_cancel_inspection()
