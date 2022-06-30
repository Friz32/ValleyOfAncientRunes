tool
extends EditorPlugin

func _enter_tree():
	add_autoload_singleton("QCore", "res://addons/qcore/scripts/system.gd")
	
	add_input_action("fullscreen", KEY_F11)

func _exit_tree():
	remove_autoload_singleton("QCore")
	
	ProjectSettings.set_setting("input/fullscreen", null)

func add_input_action(name: String, scancode: int, control := false) -> void:
	var event = InputEventKey.new()
	event.control = control
	event.scancode = scancode
	
	var action = {deadzone = 0.5, events = []}
	action["events"].append(event)
	ProjectSettings.set_setting("input/" + name, action)
