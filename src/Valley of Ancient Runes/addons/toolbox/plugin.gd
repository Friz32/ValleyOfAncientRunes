tool
extends EditorPlugin

func _enter_tree():
	add_autoload_singleton("TB", "res://addons/toolbox/scripts/system.gd")
	add_autoload_singleton("TBSettings", "res://addons/toolbox/scripts/settings.gd")

func _exit_tree():
	remove_autoload_singleton("TB")
	remove_autoload_singleton("TBSettings")
