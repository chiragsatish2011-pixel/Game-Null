# rail_sleepers_multimesh.gd
# PROJECT NULL — MultiMesh Rail Sleepers (Timber Ties) Generator
# Compliance: Strictly 1 draw call for 40 instances along 24m track
@tool
class_name RailSleepersMultiMesh
extends MultiMeshInstance3D

@export var sleeper_count: int = 40
@export var track_length: float = 24.0
@export var sleeper_size: Vector3 = Vector3(1.8, 0.12, 0.22)

func _ready() -> void:
	generate_sleepers()

func generate_sleepers() -> void:
	if multimesh == null:
		multimesh = MultiMesh.new()
		multimesh.transform_format = MultiMesh.TRANSFORM_3D
	
	multimesh.instance_count = sleeper_count
	
	if multimesh.mesh == null:
		var box := BoxMesh.new()
		box.size = sleeper_size
		box.material = preload("res://assets/materials/mat_railway_sleeper.tres")
		multimesh.mesh = box
	
	var step: float = track_length / float(sleeper_count)
	var start_z: float = - (track_length * 0.5) + (step * 0.5)
	
	for i in range(sleeper_count):
		var z: float = start_z + float(i) * step
		var t := Transform3D(Basis.IDENTITY, Vector3(0.0, 0.0, z))
		multimesh.set_instance_transform(i, t)
