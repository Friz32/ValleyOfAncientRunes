extends Node

func _input(event):
	if is_debug_allowed():
		if event.is_action_pressed("debug_mouse_mode"):
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE else Input.MOUSE_MODE_VISIBLE)
		
		if event.is_action_pressed("debug_reload_scene"):
			get_tree().reload_current_scene()
		
		if event.is_action_pressed("debug_first_scene"):
			get_tree().change_scene(ProjectSettings["application/run/main_scene"])

func is_debug_allowed():
	return ProjectSettings.get_setting("qdebug/debug_enabled") && (OS.has_feature("editor") || ProjectSettings.get_setting("qdebug/debug_enabled_export"))
