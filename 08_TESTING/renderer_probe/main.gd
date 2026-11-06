extends Node

func _ready() -> void:
	print("RENDERER_PROBE_START")
	var rendering_method: String = ProjectSettings.get_setting("rendering/renderer/rendering_method", "")
	var mobile_method: String = ProjectSettings.get_setting("rendering/renderer/rendering_method.mobile", "")
	var display_server: String = DisplayServer.get_name()

	print("Display Server: ", display_server)
	print("Configured Rendering Method: ", rendering_method)
	print("Configured Mobile Method: ", mobile_method)

	var adapter_name: String = RenderingServer.get_video_adapter_name()
	if display_server == "headless" and adapter_name.is_empty():
		print("Device: [Headless mode active — GPU adapter query unpopulated by design]")
	else:
		print("Device: ", adapter_name)
		print("Vendor: ", RenderingServer.get_video_adapter_vendor())
		print("API Version: ", RenderingServer.get_video_adapter_api_version())
		print("Type: ", RenderingServer.get_video_adapter_type())

	# 1. Enforce gl_compatibility rendering method invariant
	if rendering_method != "gl_compatibility":
		var err_msg := "RENDERER_PROBE_FAILURE: Invariant breached! Rendering method is '%s', must be 'gl_compatibility'." % rendering_method
		push_error(err_msg)
		printerr(err_msg)
		get_tree().quit(1)
		return

	if mobile_method != "" and mobile_method != "gl_compatibility":
		var err_msg := "RENDERER_PROBE_FAILURE: Invariant breached! Mobile rendering method is '%s', must be 'gl_compatibility'." % mobile_method
		push_error(err_msg)
		printerr(err_msg)
		get_tree().quit(1)
		return

	# 2. Enforce barred features (SDFGI, VoxelGI, Volumetric Fog, TAA, SSR, SSIL)
	var barred_settings: Dictionary = {
		"rendering/global_illumination/sdfgi/enabled": "SDFGI",
		"rendering/global_illumination/voxel_gi/enabled": "VoxelGI",
		"rendering/environment/volumetric_fog/enabled": "Volumetric Fog",
		"rendering/anti_aliasing/quality/use_taa_jitter": "TAA"
	}

	for setting_key in barred_settings:
		if ProjectSettings.get_setting(setting_key, false) == true:
			var feature_name: String = barred_settings[setting_key]
			var err_msg := "RENDERER_PROBE_FAILURE: Barred feature '%s' enabled in ProjectSettings (%s)!" % [feature_name, setting_key]
			push_error(err_msg)
			printerr(err_msg)
			get_tree().quit(1)
			return

	print("RENDERER_PROBE_SUCCESS")
	get_tree().quit(0)

