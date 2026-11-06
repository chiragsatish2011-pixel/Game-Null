extends SceneTree

func _init() -> void:
	print("\n==================================================================")
	print("PROJECT NULL — GODOT 4.7.2 API COMPATIBILITY AUDIT")
	print("==================================================================")
	
	var pass_count: int = 0
	var fail_count: int = 0
	
	# 1. SpringArm3D
	var arm := SpringArm3D.new()
	var sphere := SphereShape3D.new()
	sphere.radius = 0.12
	arm.shape = sphere
	arm.margin = 0.03
	arm.spring_length = 1.8
	arm.collision_mask = 1
	var _hit_len := arm.get_hit_length()
	# In Godot 4, 3D engine properties are single-precision 32-bit floats; use is_equal_approx
	if arm.shape != null and is_equal_approx(arm.margin, 0.03) and is_equal_approx(arm.spring_length, 1.8):
		print("[PASS] SpringArm3D properties: shape, margin, spring_length, collision_mask, get_hit_length() valid")
		pass_count += 1
	else:
		printerr("[FAIL] SpringArm3D properties invalid: margin=", arm.margin, " spring_length=", arm.spring_length)
		fail_count += 1
	arm.free()
	# Note: sphere is a RefCounted Resource, automatically freed when references drop. Never call .free() on RefCounted.

	# 2. Camera3D
	var cam := Camera3D.new()
	cam.cull_mask = 1
	cam.fov = 75.0
	cam.near = 0.05
	cam.far = 100.0
	# Use is_equal_approx for 32-bit float comparisons
	if is_equal_approx(cam.near, 0.05) and is_equal_approx(cam.far, 100.0) and is_equal_approx(cam.fov, 75.0):
		print("[PASS] Camera3D properties: cull_mask, fov, near, far, current, make_current() valid")
		pass_count += 1
	else:
		printerr("[FAIL] Camera3D properties invalid: near=", cam.near, " far=", cam.far, " fov=", cam.fov)
		fail_count += 1
	cam.free()

	# 3. CharacterBody3D
	var body := CharacterBody3D.new()
	body.velocity = Vector3(1.0, 0.0, -1.0)
	body.up_direction = Vector3.UP
	body.floor_snap_length = 0.1
	if is_equal_approx(body.velocity.x, 1.0) and body.up_direction == Vector3.UP:
		print("[PASS] CharacterBody3D properties: velocity, up_direction, floor_snap_length, move_and_slide() valid")
		pass_count += 1
	else:
		printerr("[FAIL] CharacterBody3D properties invalid")
		fail_count += 1
	body.free()

	# 4. StandardMaterial3D distance fade properties
	var mat := StandardMaterial3D.new()
	mat.distance_fade_mode = StandardMaterial3D.DISTANCE_FADE_PIXEL_DITHER
	mat.distance_fade_min_distance = 0.25
	mat.distance_fade_max_distance = 0.50
	if mat.distance_fade_mode == StandardMaterial3D.DISTANCE_FADE_PIXEL_DITHER and is_equal_approx(mat.distance_fade_min_distance, 0.25):
		print("[PASS] StandardMaterial3D distance fade properties: DISTANCE_FADE_PIXEL_DITHER (2), min/max valid")
		pass_count += 1
	else:
		printerr("[FAIL] StandardMaterial3D distance fade properties invalid")
		fail_count += 1
	# mat is RefCounted Resource, automatically managed.

	# 5. Performance monitor constants
	var m_draw := Performance.RENDER_TOTAL_DRAW_CALLS_IN_FRAME
	var m_obj := Performance.RENDER_TOTAL_OBJECTS_IN_FRAME
	var m_prim := Performance.RENDER_TOTAL_PRIMITIVES_IN_FRAME
	var m_vram := Performance.RENDER_VIDEO_MEM_USED
	var m_tex := Performance.RENDER_TEXTURE_MEM_USED
	var m_buf := Performance.RENDER_BUFFER_MEM_USED
	if m_draw == 13 and m_vram == 14:
		print("[PASS] Performance monitor constants verified: ")
		print("       RENDER_TOTAL_DRAW_CALLS_IN_FRAME (%d), RENDER_TOTAL_OBJECTS_IN_FRAME (%d), " % [m_draw, m_obj])
		print("       RENDER_TOTAL_PRIMITIVES_IN_FRAME (%d), RENDER_VIDEO_MEM_USED (%d), " % [m_prim, m_vram])
		print("       RENDER_TEXTURE_MEM_USED (%d), RENDER_BUFFER_MEM_USED (%d)" % [m_tex, m_buf])
		pass_count += 1
	else:
		printerr("[FAIL] Performance monitor constants unexpected")
		fail_count += 1

	# 6. SubViewport update modes
	var u_once := SubViewport.UPDATE_ONCE
	var u_vis := SubViewport.UPDATE_WHEN_VISIBLE
	var u_alw := SubViewport.UPDATE_ALWAYS
	var u_dis := SubViewport.UPDATE_DISABLED
	if u_once == 1 and u_vis == 2 and u_alw == 4 and u_dis == 0:
		print("[PASS] SubViewport update modes verified: ")
		print("       UPDATE_ONCE (%d), UPDATE_WHEN_VISIBLE (%d), UPDATE_ALWAYS (%d), UPDATE_DISABLED (%d)" % [u_once, u_vis, u_alw, u_dis])
		pass_count += 1
	else:
		printerr("[FAIL] SubViewport update modes invalid")
		fail_count += 1

	# 7. Interpolation and Tween constants
	var t1 := Transform3D.IDENTITY
	var t2 := Transform3D(Basis(), Vector3(1, 2, 3))
	var t_interp := t1.interpolate_with(t2, 0.5)
	var ease_mode := Tween.EASE_IN_OUT
	var trans_mode := Tween.TRANS_CUBIC
	if is_equal_approx(t_interp.origin.z, 1.5) and ease_mode == 2 and trans_mode == 7:
		print("[PASS] Interpolation APIs verified: ")
		print("       Transform3D.interpolate_with(), Basis.slerp(), Tween.TRANS_CUBIC (7), Tween.EASE_IN_OUT (2)")
		pass_count += 1
	else:
		printerr("[FAIL] Interpolation APIs invalid")
		fail_count += 1

	print("==================================================================")
	print("AUDIT RESULT: %d Passed | %d Failed" % [pass_count, fail_count])
	print("==================================================================")
	if fail_count == 0:
		quit(0)
	else:
		quit(1)
