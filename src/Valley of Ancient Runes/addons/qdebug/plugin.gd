tool
extends EditorPlugin

func _enter_tree():
	add_autoload_singleton("QDebug", "res://addons/qdebug/scripts/system.gd")
	
	add_input_action("debug_mouse_mode", KEY_M, true)
	add_input_action("debug_reload_scene", KEY_R, true)
	add_input_action("debug_first_scene", KEY_F, true)
	
	if !ProjectSettings.has_setting("qdebug/debug_enabled"):
		ProjectSettings.set_setting("qdebug/debug_enabled", true)
	if !ProjectSettings.has_setting("qdebug/debug_enabled_export"):
		ProjectSettings.set_setting("qdebug/debug_enabled_export", false)

func _exit_tree():
	remove_autoload_singleton("QDebug")
	
	ProjectSettings.set_setting("input/debug_mouse_mode", null)
	ProjectSettings.set_setting("input/debug_reload_scene", null)
	ProjectSettings.set_setting("input/debug_first_scene", null)
	
	ProjectSettings.set_setting("qdebug/debug_enabled", null)
	ProjectSettings.set_setting("qdebug/debug_enabled_export", null)

func add_input_action(name: String, scancode: int, control := false) -> void:
	var event = InputEventKey.new()
	event.control = control
	event.scancode = scancode
	
	var action = {deadzone = 0.5, events = []}
	action["events"].append(event)
	ProjectSettings.set_setting("input/" + name, action)
