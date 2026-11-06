extends Node

func _ready() -> void:
	print("==================================================================")
	print("PROJECT NULL — RAILWAY PUZZLE INTERLOCKING VERIFICATION SUITE")
	print("Target Scene: res://scenes/world/vesper_01/shunting_cut_platform_02.tscn")
	print("==================================================================")
	
	_run_verification()

func _run_verification() -> void:
	var level := get_parent()
	var lever: LeverInterlocking = level.get_node_or_null("PlatformProps/PropInterlockingLever14")
	if lever == null:
		printerr("[FAIL] PropInterlockingLever14 not found in PlatformProps")
		get_tree().quit(1)
		return
	print("[PASS] PropInterlockingLever14 found and instantiated.")
	
	# Test 1: Initial state verification
	assert(lever.current_state == LeverInterlocking.LeverState.NORMAL, "Lever should start in NORMAL state")
	assert(GameState.lever_14_switched == false, "GameState.lever_14_switched should start false")
	var initial_deg: float = rad_to_deg(lever.lever_mesh.rotation.x)
	assert(abs(initial_deg - (-15.0)) < 0.5, "LeverMesh rotation should start near -15 deg, got: %.2f" % initial_deg)
	print("[PASS] Test 1: Initial state verified (NORMAL, rotation=%.1f deg, GameState=false)" % initial_deg)
	
	# Setup signal spy for EventBus using Dictionary container
	var received_events: Dictionary = {
		"notification": "",
		"objective": {},
		"lever_toggled": {}
	}
	
	EventBus.notification_requested.connect(func(text: String, _duration: float):
		received_events["notification"] = text
		print("[EVENTBUS NOTIFICATION] %s" % text)
	)
	EventBus.objective_updated.connect(func(obj_id: String, title: String, desc: String):
		received_events["objective"] = {"id": obj_id, "title": title, "desc": desc}
		print("[EVENTBUS OBJECTIVE] Title: '%s' | Desc: '%s'" % [title, desc])
	)
	EventBus.lever_toggled.connect(func(id: int, is_pulled: bool):
		received_events["lever_toggled"] = {"id": id, "is_pulled": is_pulled}
	)
	
	# Test 2: Interact with lever (pull)
	print("\n--- Testing Lever Throw (NORMAL -> PULLED) ---")
	lever.interact()
	
	assert(lever.current_state == LeverInterlocking.LeverState.PULLED, "Lever state should now be PULLED")
	assert(GameState.lever_14_switched == true, "GameState.lever_14_switched should be true")
	assert(received_events["notification"] == "TURNOUT 14 THROWN // EASTERN TRACK SWITCH ENGAGED", "Notification mismatch, got: " + received_events["notification"])
	assert(GameState.current_objective_title == "Platform 2 Clearance Granted", "Objective title mismatch")
	assert(GameState.current_objective_desc == "Track turnout aligned. Access to Drainage Culvert Sector 02 is now open.", "Objective desc mismatch")
	assert(received_events["objective"].get("title") == "Platform 2 Clearance Granted", "EventBus objective title mismatch")
	assert(received_events["lever_toggled"].get("id") == 14 and received_events["lever_toggled"].get("is_pulled") == true, "EventBus lever_toggled mismatch")
	print("[PASS] Test 2: Lever throw signals, GameState, and EventBus notifications verified.")
	
	# Test 3: Animation tick simulation (wait for tween completion)
	var tween_timer := get_tree().create_timer(0.8)
	await tween_timer.timeout
	
	var pulled_deg: float = rad_to_deg(lever.lever_mesh.rotation.x)
	assert(abs(pulled_deg - 25.0) < 0.5, "LeverMesh rotation should animate to +25 deg, got: %.2f" % pulled_deg)
	print("[PASS] Test 3: Lever Tween completed: rotation=%.1f deg (target: +25.0 deg)" % pulled_deg)
	
	# Test 4: Physical world state response in level
	var tie_rod: Node3D = level.get_node_or_null("Architecture/TurnoutMechanism/TurnoutTieRod")
	var blade: Node3D = level.get_node_or_null("Architecture/TurnoutMechanism/TurnoutPointBlade")
	var culvert_gate: Node3D = level.get_node_or_null("Architecture/DrainageCulvertSector02/CulvertGate")
	var culvert_lamp: OmniLight3D = level.get_node_or_null("Architecture/DrainageCulvertSector02/CulvertIndicatorLamp")
	
	assert(tie_rod != null, "TurnoutTieRod should exist")
	assert(blade != null, "TurnoutPointBlade should exist")
	assert(culvert_gate != null, "CulvertGate should exist")
	assert(culvert_lamp != null, "CulvertIndicatorLamp should exist")
	
	# Wait for gate animation to finish (duration is 1.4s)
	var gate_timer := get_tree().create_timer(1.0)
	await gate_timer.timeout
	
	print("[WORLD STATE] Tie Rod position.x: %.3f (Target: -3.150)" % tie_rod.position.x)
	print("[WORLD STATE] Blade position.x: %.3f (Target: -3.760)" % blade.position.x)
	print("[WORLD STATE] Culvert Gate position.y: %.3f (Target: 4.000)" % culvert_gate.position.y)
	print("[WORLD STATE] Culvert Lamp Color: %s (Target Green)" % str(culvert_lamp.light_color))
	
	assert(abs(tie_rod.position.x - (-3.15)) < 0.05, "Tie rod should shift to -3.15")
	assert(abs(blade.position.x - (-3.76)) < 0.05, "Point blade should shift to -3.76")
	assert(abs(culvert_gate.position.y - 4.0) < 0.1, "Culvert gate should lift to 4.0")
	assert(culvert_lamp.light_color.g > 0.8, "Culvert lamp should turn green")
	print("[PASS] Test 4: World state changes verified (tie rod shifted, blade shifted, culvert gate elevated, lamp green).")
	
	# Test 5: Lever Reset (PULLED -> NORMAL)
	print("\n--- Testing Lever Reset (PULLED -> NORMAL) ---")
	lever.interact()
	assert(lever.current_state == LeverInterlocking.LeverState.NORMAL, "Lever state should return to NORMAL")
	assert(GameState.lever_14_switched == false, "GameState.lever_14_switched should return to false")
	
	var reset_timer := get_tree().create_timer(1.6)
	await reset_timer.timeout
	
	var reset_deg: float = rad_to_deg(lever.lever_mesh.rotation.x)
	assert(abs(reset_deg - (-15.0)) < 0.5, "LeverMesh rotation should return to -15 deg, got: %.2f" % reset_deg)
	assert(abs(tie_rod.position.x - (-3.3)) < 0.05, "Tie rod should return to -3.3")
	assert(abs(culvert_gate.position.y - 1.25) < 0.1, "Culvert gate should return to closed position 1.25")
	print("[PASS] Test 5: Lever reset and world return to normal verified (rotation=%.1f deg, gate=%.2fm, tie_rod=%.2fm)." % [reset_deg, culvert_gate.position.y, tie_rod.position.x])
	
	print("\n==================================================================")
	print("ALL 5 VERIFICATION TESTS PASSED SUCCESSFULLY!")
	print("==================================================================")
	get_tree().quit(0)
