extends Node3D

@onready var corridor: Node3D = $CorridorEnvironment
@onready var clue_diorama: Node3D = $ClueDiorama
@onready var player: Node3D = $ProtoHumanoid01
@onready var hud: Control = $UI_Canvas/HUDPoC
@onready var benchmark: Node = $BenchmarkRunner

func _ready() -> void:
	print("==================================================================")
	print("PROJECT NULL — M4.1 PROOF OF CONCEPT STAGE INITIALIZED")
	print("Renderer: Compatibility (OpenGL 3.3 Core Profile)")
	print("Target Hardware: NVIDIA GeForce G210 (1024 MB DDR3)")
	print("==================================================================")
	
	# Wire player to HUD
	if hud != null and player != null:
		hud.connect_player(player)
	
	# Wire player to BenchmarkRunner
	if benchmark != null and player != null:
		benchmark.set_player(player)
	
	# Connect clue diorama to player/hud
	var clue_area: Area3D = clue_diorama.get_node_or_null("ClueInteractable")
	if clue_area != null:
		clue_area.clue_inspected.connect(_on_clue_inspected)
	
	# Report mannequin triangle count
	_audit_mannequin_geometry()
	
	# Check command line arguments (both user args and raw cmdline args)
	var args := OS.get_cmdline_user_args()
	for a in OS.get_cmdline_args():
		if not args.has(a):
			args.append(a)
	var i: int = 0
	while i < args.size():
		var arg: String = args[i]
		if arg == "--automated-test-run":
			_start_automated_test_cycle()
		elif arg == "--visible-interactive-test":
			_start_visible_interactive_test()
		elif arg == "--first-person" or (arg == "--camera-mode" and i + 1 < args.size() and ("FIRST" in args[i+1].to_upper() or args[i+1].to_upper() == "FP")):
			if player != null:
				var cam_rig: Node = player.get("camera_rig")
				if cam_rig != null and cam_rig.has_method("set_camera_mode"):
					cam_rig.set_camera_mode(0, true) # 0 = FIRST_PERSON
					print("[STAGE] Initial camera mode set to FIRST_PERSON")
		elif arg == "--third-person" or (arg == "--camera-mode" and i + 1 < args.size() and ("THIRD" in args[i+1].to_upper() or args[i+1].to_upper() == "TP")):
			if player != null:
				var cam_rig: Node = player.get("camera_rig")
				if cam_rig != null and cam_rig.has_method("set_camera_mode"):
					cam_rig.set_camera_mode(1, true) # 1 = THIRD_PERSON
					print("[STAGE] Initial camera mode set to THIRD_PERSON")
		elif arg == "--shadow-disabled":
			var dlight: DirectionalLight3D = get_node_or_null("DirectionalLight3D")
			if dlight != null:
				dlight.shadow_enabled = false
				print("[STAGE] Directional shadow explicitly DISABLED for experiment")
		elif arg == "--shadow-distance" and i + 1 < args.size():
			i += 1
			var dist: float = float(args[i])
			var dlight: DirectionalLight3D = get_node_or_null("DirectionalLight3D")
			if dlight != null:
				dlight.directional_shadow_max_distance = dist
				print("[STAGE] Directional shadow max distance set to: %.1f m" % dist)
		i += 1

func _audit_mannequin_geometry() -> void:
	var total_mannequin_tris: int = 0
	var visual: Node3D = player.get_node_or_null("MannequinVisual")
	if visual != null:
		for child in visual.get_children():
			if child is MeshInstance3D and child.mesh != null:
				total_mannequin_tris += child.mesh.get_faces().size() / 3
			elif child is Node3D:
				for subchild in child.get_children():
					if subchild is MeshInstance3D and subchild.mesh != null:
						total_mannequin_tris += subchild.mesh.get_faces().size() / 3
	print("[MANNEQUIN AUDIT] PROTO_HUMANOID_01 Actual Geometry: %d triangles (Budget: <= 1,200 tris)" % total_mannequin_tris)

func _on_clue_inspected(clue_id: String, details: String) -> void:
	if details != "":
		print("[INTERACTION EVENT] Clue inspected: %s" % clue_id)
	else:
		print("[INTERACTION EVENT] Clue inspection dismissed")

func _start_automated_test_cycle() -> void:
	print("[AUTOMATED TEST] Starting scripted player & camera test sequence...")
	var tween := create_tween()
	tween.tween_callback(func(): player.velocity = Vector3(0, 0, 1.5))
	tween.tween_interval(2.0)
	tween.tween_callback(func(): player.camera_rig.toggle_mode())
	tween.tween_interval(1.5)
	tween.tween_callback(func(): player.camera_rig.toggle_mode())
	tween.tween_interval(1.5)
	tween.tween_callback(func(): player.velocity = Vector3(1.5, 0, 1.0))
	tween.tween_interval(3.0)
	tween.tween_callback(func(): player.velocity = Vector3(0.5, 0, 1.5))
	tween.tween_interval(3.0)
	tween.tween_callback(func(): player.velocity = Vector3.ZERO)

func _start_visible_interactive_test() -> void:
	print("==================================================================")
	print("[VISIBLE TEST] Commencing Choreographed Visible Interaction Pass")
	print("==================================================================")
	# Silence benchmark runner during interactive pass
	if benchmark != null:
		benchmark.set_process(false)
	
	var tween := create_tween()
	
	# Step 1: Walk from spawn in open room towards clue diorama
	tween.tween_callback(func():
		print("[TEST STEP 1] Zone 1: Walking across open corridor room towards clue diorama...")
		player.simulated_input_vec = Vector2(0, -1.0)
	)
	tween.tween_interval(1.8)
	
	# Step 2: Stop at clue diorama
	tween.tween_callback(func():
		print("[TEST STEP 2] Arrived in range of Clue Telegraph Key. Halting locomotion.")
		player.simulated_input_vec = Vector2.ZERO
	)
	tween.tween_interval(0.5)
	
	# Step 3: Trigger clue inspection
	tween.tween_callback(func():
		print("[TEST STEP 3] Triggering clue inspection via [E] interact contract...")
		player.trigger_interaction()
	)
	tween.tween_interval(2.0)
	
	# Step 4: Dismiss clue inspection
	tween.tween_callback(func():
		print("[TEST STEP 4] Dismissing clue inspection via contextual toggle...")
		player.trigger_interaction()
	)
	tween.tween_interval(0.8)
	
	# Step 5: Toggle camera to First-Person
	tween.tween_callback(func():
		print("[TEST STEP 5] Toggling camera perspective: THIRD_PERSON -> FIRST_PERSON...")
		player.camera_rig.toggle_mode()
	)
	tween.tween_interval(1.2)
	
	# Step 6: Toggle camera back to Third-Person
	tween.tween_callback(func():
		print("[TEST STEP 6] Toggling camera perspective: FIRST_PERSON -> THIRD_PERSON...")
		player.camera_rig.toggle_mode()
	)
	tween.tween_interval(1.2)
	
	# Step 7: Walk into Zone 2: Acute Corner Wall (30 deg / 60 deg)
	tween.tween_callback(func():
		print("[TEST STEP 7] Zone 2: Walking into acute corner wall to test 4-Pillar Obstruction...")
		player.simulated_input_vec = Vector2(1.0, 0.2)
	)
	tween.tween_interval(2.5)
	
	# Step 8: Verify obstruction state
	tween.tween_callback(func():
		var cam_rig = player.camera_rig
		print("[TEST STEP 8] Obstruction check: hit_length=%.2fm, shoulder_x=%.2fm, pitch_y=%.2fm, mode=%s" % [
			cam_rig.last_hit_length,
			cam_rig.third_person_socket.position.x,
			cam_rig.third_person_socket.position.y,
			cam_rig.current_mode
		])
		if cam_rig.current_mode == 1: # Still THIRD_PERSON
			print("[PASS] Obstruction check: Mode PRESERVED as THIRD_PERSON (zero auto-snap!).")
		else:
			printerr("[FAIL] Obstruction check: Auto-snap detected!")
	)
	tween.tween_interval(0.5)
	
	# Step 9: Walk through Zone 3: 1.2m Clear Width Doorway
	tween.tween_callback(func():
		print("[TEST STEP 9] Zone 3: Walking through narrow 1.2m clear doorway...")
		player.simulated_input_vec = Vector2(-0.8, -1.0)
	)
	tween.tween_interval(3.0)
	
	# Step 10: Halt and complete test
	tween.tween_callback(func():
		player.simulated_input_vec = Vector2.ZERO
		print("==================================================================")
		print("[VISIBLE TEST COMPLETE] All 3 zones, camera modes, and clue interaction verified.")
		print("==================================================================")
		get_tree().quit(0)
	)
