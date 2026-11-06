extends Node3D

enum CameraMode {
	FIRST_PERSON,
	THIRD_PERSON,
	TRANSITIONING,
	INSPECTION
}

signal camera_mode_changed(new_mode: CameraMode)
signal transition_completed(current_mode: CameraMode)

@export var mouse_sensitivity: float = 0.002
@export var min_pitch: float = -1.45 # ~ -83 degrees
@export var max_pitch: float = 1.45  # ~ +83 degrees
@export var transition_duration: float = 0.28 # seconds

@onready var first_person_anchor: Marker3D = $FirstPersonAnchor
@onready var third_person_pivot: Node3D = $ThirdPersonPivot
@onready var spring_arm: SpringArm3D = $ThirdPersonPivot/SpringArm3D
@onready var third_person_socket: Marker3D = $ThirdPersonPivot/SpringArm3D/ThirdPersonSocket
@onready var camera: Camera3D = $InterpolatedCamera3D

var current_mode: CameraMode = CameraMode.THIRD_PERSON
var _previous_mode: CameraMode = CameraMode.THIRD_PERSON

var _pitch: float = 0.0
var _yaw: float = 0.0

# 4-Pillar Obstruction policy parameters
const MIN_SPRING_LENGTH: float = 0.25
const NOMINAL_SPRING_LENGTH: float = 1.80
const NOMINAL_SHOULDER_X: float = 0.35
const COMPRESSION_THRESHOLD: float = 0.80

var _is_transitioning: bool = false
var _transition_progress: float = 1.0
var _transition_start_transform: Transform3D
var _inspection_target_transform: Transform3D

# Diagnostic tracking
var compression_event_count: int = 0
var mode_switch_count: int = 0
var last_hit_length: float = 1.80

func _ready() -> void:
	# Configure SpringArm3D calibrated probe
	var sphere := SphereShape3D.new()
	sphere.radius = 0.12
	spring_arm.shape = sphere
	spring_arm.margin = 0.03
	spring_arm.spring_length = NOMINAL_SPRING_LENGTH
	spring_arm.collision_mask = 1 # World Static only
	
	# Initial camera alignment
	set_camera_mode(CameraMode.THIRD_PERSON, true)

func _process(delta: float) -> void:
	if current_mode == CameraMode.TRANSITIONING:
		_process_transition(delta)
	elif current_mode == CameraMode.THIRD_PERSON:
		_process_third_person_obstruction(delta)
	elif current_mode == CameraMode.FIRST_PERSON:
		_process_first_person()
	elif current_mode == CameraMode.INSPECTION:
		camera.global_transform = camera.global_transform.interpolate_with(_inspection_target_transform, 8.0 * delta)

func handle_mouse_look(relative: Vector2, parent_body: CharacterBody3D) -> void:
	if current_mode == CameraMode.INSPECTION:
		return
	
	_yaw -= relative.x * mouse_sensitivity
	_pitch = clamp(_pitch - relative.y * mouse_sensitivity, min_pitch, max_pitch)
	
	if current_mode == CameraMode.FIRST_PERSON:
		# Body rotates with yaw; anchor tilts with pitch
		parent_body.rotate_y(-relative.x * mouse_sensitivity)
		first_person_anchor.rotation.x = _pitch
		_yaw = 0.0 # yaw absorbed by body
	elif current_mode == CameraMode.THIRD_PERSON or current_mode == CameraMode.TRANSITIONING:
		# Orbit pivot rotates in local space
		third_person_pivot.rotation.y = _yaw
		third_person_pivot.rotation.x = _pitch

func toggle_mode() -> void:
	if current_mode == CameraMode.INSPECTION or _is_transitioning:
		return
	
	mode_switch_count += 1
	if current_mode == CameraMode.FIRST_PERSON:
		set_camera_mode(CameraMode.THIRD_PERSON, false)
	else:
		set_camera_mode(CameraMode.FIRST_PERSON, false)

func set_camera_mode(new_mode: CameraMode, instant: bool = false) -> void:
	if instant:
		current_mode = new_mode
		_is_transitioning = false
		_transition_progress = 1.0
		_apply_cull_mask(new_mode)
		if is_inside_tree():
			if new_mode == CameraMode.FIRST_PERSON:
				camera.global_transform = first_person_anchor.global_transform
			else:
				camera.global_transform = third_person_socket.global_transform
		camera_mode_changed.emit(current_mode)
		return

	_previous_mode = current_mode
	current_mode = CameraMode.TRANSITIONING
	_is_transitioning = true
	_transition_progress = 0.0
	_transition_start_transform = camera.global_transform
	_target_mode_after_transition = new_mode
	_apply_cull_mask(new_mode)
	camera_mode_changed.emit(current_mode)

var _target_mode_after_transition: CameraMode = CameraMode.THIRD_PERSON

func _process_transition(delta: float) -> void:
	_transition_progress += delta / transition_duration
	var t: float = clamp(_transition_progress, 0.0, 1.0)
	# Hermite cubic smoothstep
	var smooth_t: float = t * t * (3.0 - 2.0 * t)
	
	var target_tf: Transform3D
	if _target_mode_after_transition == CameraMode.FIRST_PERSON:
		target_tf = first_person_anchor.global_transform
	else:
		target_tf = third_person_socket.global_transform
	
	camera.global_transform = _transition_start_transform.interpolate_with(target_tf, smooth_t)
	
	if t >= 1.0:
		current_mode = _target_mode_after_transition
		_is_transitioning = false
		transition_completed.emit(current_mode)
		camera_mode_changed.emit(current_mode)

func _process_first_person() -> void:
	camera.global_transform = first_person_anchor.global_transform

func _process_third_person_obstruction(_delta: float) -> void:
	# 4-Pillar Obstruction Policy
	var hit_len: float = spring_arm.get_hit_length()
	last_hit_length = hit_len
	
	# 1. Hard Floor: Clamp length so camera does not collapse inside head
	if hit_len < COMPRESSION_THRESHOLD:
		compression_event_count += 1
		var u: float = clamp((COMPRESSION_THRESHOLD - hit_len) / (COMPRESSION_THRESHOLD - MIN_SPRING_LENGTH), 0.0, 1.0)
		
		# 2. Dynamic Shoulder Centering: (X: 0.35m -> 0.05m)
		third_person_socket.position.x = lerp(NOMINAL_SHOULDER_X, 0.05, u)
		
		# 3. Vertical Pitch Lift: (+0.15m lift when compressed)
		third_person_socket.position.y = lerp(0.15, 0.30, u)
	else:
		third_person_socket.position.x = NOMINAL_SHOULDER_X
		third_person_socket.position.y = 0.15
	
	if is_inside_tree():
		camera.global_transform = third_person_socket.global_transform

func enter_inspection(anchor_transform: Transform3D) -> void:
	_previous_mode = current_mode
	current_mode = CameraMode.INSPECTION
	_inspection_target_transform = anchor_transform
	camera_mode_changed.emit(current_mode)

func exit_inspection() -> void:
	if current_mode == CameraMode.INSPECTION:
		set_camera_mode(_previous_mode, false)

func _apply_cull_mask(mode: CameraMode) -> void:
	if mode == CameraMode.FIRST_PERSON:
		# Layer 1 = World & Body; Layer 2 = HeadOnly.
		# Cull layer 2 so player never sees inside own head!
		camera.cull_mask = 1
	else:
		# Third person sees everything
		camera.cull_mask = 1 | 2
