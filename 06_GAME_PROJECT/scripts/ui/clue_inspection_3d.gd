# clue_inspection_3d.gd
# PROJECT NULL — Interactive 3D Forensic Clue Inspection Controller
# gl_compatibility (OpenGL 3.3) / Low-VRAM Baseline compliant
class_name ClueInspection3D
extends SubViewportContainer

@export var rotation_sensitivity: float = 0.008
@export var pitch_limit_deg: float = 80.0
@export var target_display_size: float = 0.65
@export var zoom_step: float = 0.1
@export var min_zoom_distance: float = 0.6
@export var max_zoom_distance: float = 2.6
@export var default_cam_distance: float = 1.4
@export var subtle_idle_spin: bool = false
@export var idle_spin_speed: float = 0.2

@onready var sub_viewport: SubViewport = $SubViewport
@onready var camera_3d: Camera3D = $SubViewport/Camera3D
@onready var clue_pivot: Node3D = $SubViewport/CluePivot

var _is_dragging: bool = false
var _current_pitch: float = 0.0
var _current_yaw: float = 0.0
var _cam_distance: float = 1.4

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP
	_cam_distance = default_cam_distance
	if is_instance_valid(camera_3d):
		camera_3d.position = Vector3(0.0, 0.0, _cam_distance)

func _process(delta: float) -> void:
	if subtle_idle_spin and not _is_dragging and is_instance_valid(clue_pivot) and clue_pivot.get_child_count() > 0:
		_current_yaw += idle_spin_speed * delta
		_update_pivot_transform()

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				_is_dragging = true
				accept_event()
			else:
				_is_dragging = false
				accept_event()
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			_adjust_zoom(-zoom_step)
			accept_event()
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			_adjust_zoom(zoom_step)
			accept_event()
	
	elif event is InputEventMouseMotion and _is_dragging:
		var rel: Vector2 = event.relative
		_current_yaw -= rel.x * rotation_sensitivity
		_current_pitch -= rel.y * rotation_sensitivity
		var max_pitch_rad: float = deg_to_rad(pitch_limit_deg)
		_current_pitch = clampf(_current_pitch, -max_pitch_rad, max_pitch_rad)
		_update_pivot_transform()
		accept_event()

func _input(event: InputEvent) -> void:
	# Release drag guard if mouse button released outside container
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			_is_dragging = false

func _adjust_zoom(delta_dist: float) -> void:
	_cam_distance = clampf(_cam_distance + delta_dist, min_zoom_distance, max_zoom_distance)
	if is_instance_valid(camera_3d):
		camera_3d.position.z = _cam_distance

func _update_pivot_transform() -> void:
	if not is_instance_valid(clue_pivot):
		return
	var yaw_basis := Basis(Vector3.UP, _current_yaw)
	var pitch_basis := Basis(Vector3.RIGHT, _current_pitch)
	clue_pivot.transform.basis = yaw_basis * pitch_basis

func reset_rotation() -> void:
	_current_pitch = 0.0
	_current_yaw = 0.0
	_is_dragging = false
	_cam_distance = default_cam_distance
	if is_instance_valid(clue_pivot):
		clue_pivot.transform.basis = Basis.IDENTITY
	if is_instance_valid(camera_3d):
		camera_3d.position = Vector3(0.0, 0.0, _cam_distance)

func clear() -> void:
	if is_instance_valid(clue_pivot):
		for child in clue_pivot.get_children():
			clue_pivot.remove_child(child)
			child.queue_free()
	reset_rotation()

func display_clue(mesh_node: Node3D) -> void:
	clear()
	if mesh_node == null:
		return
	
	# Determine search root and collect MeshInstance3D nodes
	var search_root: Node3D = mesh_node
	if "target_mesh" in mesh_node and mesh_node.target_mesh is GeometryInstance3D:
		search_root = mesh_node.target_mesh
	elif mesh_node is Area3D and mesh_node.get_parent() is Node3D:
		search_root = mesh_node.get_parent()
	
	var mesh_instances: Array[MeshInstance3D] = []
	_collect_meshes(search_root, mesh_instances)
	
	if mesh_instances.is_empty():
		# Fallback: check if the original mesh_node itself has meshes
		if search_root != mesh_node:
			_collect_meshes(mesh_node, mesh_instances)
	
	if mesh_instances.is_empty():
		return
	
	var model_root := Node3D.new()
	model_root.name = "ClueModelRoot"
	clue_pivot.add_child(model_root)
	
	var base_xf: Transform3D = search_root.global_transform if search_root.is_inside_tree() else Transform3D.IDENTITY
	var combined_aabb: AABB = AABB()
	var has_aabb: bool = false
	
	for src_mesh in mesh_instances:
		if src_mesh.mesh == null:
			continue
		
		var clone := MeshInstance3D.new()
		clone.mesh = src_mesh.mesh
		clone.material_override = src_mesh.material_override
		clone.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
		
		# Transfer surface materials
		for surf_idx in range(src_mesh.get_surface_override_material_count()):
			var mat: Material = src_mesh.get_surface_override_material(surf_idx)
			if mat != null:
				clone.set_surface_override_material(surf_idx, mat)
		
		# Calculate relative transform to base_xf
		if src_mesh.is_inside_tree() and search_root.is_inside_tree():
			clone.transform = base_xf.affine_inverse() * src_mesh.global_transform
		else:
			clone.transform = src_mesh.transform
		
		model_root.add_child(clone)
		
		var child_aabb: AABB = clone.transform * src_mesh.mesh.get_aabb()
		if not has_aabb:
			combined_aabb = child_aabb
			has_aabb = true
		else:
			combined_aabb = combined_aabb.merge(child_aabb)
	
	# Center model at pivot and normalize size
	if has_aabb:
		var center: Vector3 = combined_aabb.position + combined_aabb.size * 0.5
		var max_dim: float = maxf(combined_aabb.size.x, maxf(combined_aabb.size.y, combined_aabb.size.z))
		model_root.position = -center
		
		if max_dim > 0.001:
			var scale_factor: float = target_display_size / max_dim
			clue_pivot.scale = Vector3.ONE * scale_factor
		else:
			clue_pivot.scale = Vector3.ONE
	else:
		clue_pivot.scale = Vector3.ONE

func _collect_meshes(node: Node, out_list: Array[MeshInstance3D]) -> void:
	if node is MeshInstance3D and node.mesh != null:
		out_list.append(node)
	for child in node.get_children():
		# Avoid descending into collision shapes, non-visual triggers, etc.
		if child is CollisionShape3D or child is Area3D:
			continue
		_collect_meshes(child, out_list)
