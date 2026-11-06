extends SceneTree

func _init() -> void:
	print("\n==================================================================")
	print("PROJECT NULL — M4.1 INTERACTIVE & FUNCTIONAL AUDIT")
	print("==================================================================")
	
	var pass_count: int = 0
	var fail_count: int = 0
	
	# Load main stage
	var stage_scene: PackedScene = load("res://scenes/poc/m4_1_poc_stage.tscn")
	if stage_scene == null:
		printerr("[FAIL] Could not load m4_1_poc_stage.tscn")
		quit(1)
		return
	
	var stage: Node3D = stage_scene.instantiate()
	root.add_child(stage)
	
	var player = stage.get_node("ProtoHumanoid01")
	var cam_rig = player.get_node("CameraDualRig")
	var camera: Camera3D = cam_rig.get_node("InterpolatedCamera3D")
	var clue = stage.get_node("ClueDiorama")
	var clue_area = clue.get_node("ClueInteractable")
	var hud = stage.get_node("UI_Canvas/HUDPoC")
	
	# Ensure rig knows about nodes
	cam_rig.camera = camera
	cam_rig.spring_arm = cam_rig.get_node("ThirdPersonPivot/SpringArm3D")
	cam_rig.third_person_socket = cam_rig.get_node("ThirdPersonPivot/SpringArm3D/ThirdPersonSocket")
	cam_rig.third_person_pivot = cam_rig.get_node("ThirdPersonPivot")
	cam_rig.first_person_anchor = cam_rig.get_node("FirstPersonAnchor")
	
	# TEST 1: Initial State & Mannequin Geometry
	var visual: Node3D = player.get_node("MannequinVisual")
	var tri_count: int = 0
	for child in visual.get_children():
		if child is MeshInstance3D and child.mesh != null:
			tri_count += child.mesh.get_faces().size() / 3
		elif child is Node3D:
			for sub in child.get_children():
				if sub is MeshInstance3D and sub.mesh != null:
					tri_count += sub.mesh.get_faces().size() / 3
	
	if tri_count == 840 and tri_count <= 1200:
		print("[PASS] Test 1: Mannequin geometry = %d triangles (Budget <= 1200 tris)" % tri_count)
		pass_count += 1
	else:
		printerr("[FAIL] Test 1: Mannequin geometry %d tris exceeded budget" % tri_count)
		fail_count += 1
	
	# TEST 2: Camera Initial State (Third Person)
	if cam_rig.current_mode == cam_rig.CameraMode.THIRD_PERSON and camera.cull_mask == 3:
		print("[PASS] Test 2: Initial camera mode is THIRD_PERSON, cull_mask includes Head (Layer 1 & 2)")
		pass_count += 1
	else:
		printerr("[FAIL] Test 2: Initial camera mode unexpected: mode=%d, mask=%d" % [cam_rig.current_mode, camera.cull_mask])
		fail_count += 1
	
	# TEST 3: Camera Mode Toggle to FIRST_PERSON
	cam_rig.set_camera_mode(cam_rig.CameraMode.FIRST_PERSON, true)
	if cam_rig.current_mode == cam_rig.CameraMode.FIRST_PERSON and camera.cull_mask == 1:
		print("[PASS] Test 3: Camera toggled to FIRST_PERSON; cull_mask excludes Head Layer 2 (cull_mask = 1)")
		pass_count += 1
	else:
		printerr("[FAIL] Test 3: First-person toggle or cull mask failed: cull_mask=%d" % camera.cull_mask)
		fail_count += 1
	
	# TEST 4: Camera Mode Toggle back to THIRD_PERSON
	cam_rig.set_camera_mode(cam_rig.CameraMode.THIRD_PERSON, true)
	if cam_rig.current_mode == cam_rig.CameraMode.THIRD_PERSON and camera.cull_mask == 3:
		print("[PASS] Test 4: Camera toggled back to THIRD_PERSON; cull_mask restored to 3")
		pass_count += 1
	else:
		printerr("[FAIL] Test 4: Return to third-person failed")
		fail_count += 1
	
	# TEST 5: 4-Pillar Obstruction Policy in Corner (NO Auto-Snap)
	# Simulate acute corner compression
	var prev_mode: int = cam_rig.current_mode
	cam_rig.spring_arm.spring_length = 0.40
	cam_rig._process_third_person_obstruction(0.016)
	
	var socket: Marker3D = cam_rig.third_person_socket
	var mode_preserved: bool = (cam_rig.current_mode == prev_mode) # Must NOT switch to first person!
	var shoulder_centered: bool = (socket.position.x < 0.35 and socket.position.x >= 0.05)
	var pitch_lifted: bool = (socket.position.y > 0.15)
	
	if mode_preserved and shoulder_centered and pitch_lifted:
		print("[PASS] Test 5: 4-Pillar Obstruction Policy: Mode preserved (NO auto-snap), shoulder centered (X=%.2fm), pitch lifted (Y=%.2fm)" % [socket.position.x, socket.position.y])
		pass_count += 1
	else:
		printerr("[FAIL] Test 5: Obstruction policy violated: mode_preserved=%s, centered=%s, lifted=%s" % [mode_preserved, shoulder_centered, pitch_lifted])
		fail_count += 1
	
	# Reset spring arm
	cam_rig.spring_arm.spring_length = 1.80
	cam_rig._process_third_person_obstruction(0.016)
	
	# TEST 6: Clue Prompt Contract
	if clue_area.can_interact() and clue_area.get_prompt() != "":
		print("[PASS] Test 6: ClueInteractable prompt contract verified: '%s'" % clue_area.get_prompt())
		pass_count += 1
	else:
		printerr("[FAIL] Test 6: Clue prompt failed")
		fail_count += 1
	
	# TEST 7: Clue Interaction Execution & Inspection State
	clue_area.interact()
	var inspecting: bool = clue_area._is_currently_inspecting
	if inspecting:
		print("[PASS] Test 7: Contextual interaction [E] triggered inspection state on clue")
		pass_count += 1
	else:
		printerr("[FAIL] Test 7: Clue interaction failed to engage")
		fail_count += 1
	
	# TEST 8: Clue Dismissal & Return
	clue_area.interact() # Toggle off
	var dismissed: bool = not clue_area._is_currently_inspecting
	if dismissed:
		print("[PASS] Test 8: Contextual interaction toggle dismissed inspection and restored state")
		pass_count += 1
	else:
		printerr("[FAIL] Test 8: Clue dismissal failed")
		fail_count += 1

	print("==================================================================")
	print("AUDIT RESULTS: %d Passed | %d Failed" % [pass_count, fail_count])
	print("==================================================================")
	
	stage.free()
	if fail_count == 0:
		quit(0)
	else:
		quit(1)
