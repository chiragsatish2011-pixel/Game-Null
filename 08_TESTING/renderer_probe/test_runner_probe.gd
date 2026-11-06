# ==============================================================================
# PROJECT NULL — Test Harness CLI Runner Probe
# File: 08_TESTING/renderer_probe/test_runner_probe.gd
# Target: Godot 4.7.2 Headless Test Architecture Audit
# ==============================================================================
extends SceneTree

var _tests_run: int = 0
var _tests_passed: int = 0
var _tests_failed: int = 0

func _init() -> void:
	print("==================================================================")
	print("RUNNING HEADLESS TEST HARNESS PROBE: test_runner_probe.gd")
	print("==================================================================")

	_run_test("test_rendering_method_invariant", _test_rendering_method_invariant)
	_run_test("test_red_green_assertion_logic", _test_red_green_assertion_logic)
	_run_test("test_math_precision_approx", _test_math_precision_approx)

	print("==================================================================")
	print("TEST RUN COMPLETE: %d Run | %d Passed | %d Failed" % [_tests_run, _tests_passed, _tests_failed])
	print("==================================================================")

	if _tests_failed > 0:
		quit(1)
	else:
		quit(0)

func _run_test(test_name: String, test_callable: Callable) -> void:
	_tests_run += 1
	var success: bool = test_callable.call()
	if success:
		_tests_passed += 1
		print("  [PASS] %s" % test_name)
	else:
		_tests_failed += 1
		printerr("  [FAIL] %s" % test_name)

func _test_rendering_method_invariant() -> bool:
	var method: Variant = ProjectSettings.get_setting("rendering/renderer/rendering_method")
	return str(method) == "gl_compatibility"

func _test_red_green_assertion_logic() -> bool:
	# Verifies assertion evaluation: 1 == 1 is true
	var expected: int = 42
	var actual: int = 42
	return expected == actual

func _test_math_precision_approx() -> bool:
	# In accordance with godot-testing: use margin for float comparisons
	var f1: float = 0.1 + 0.2
	var f2: float = 0.3
	return is_equal_approx(f1, f2)
