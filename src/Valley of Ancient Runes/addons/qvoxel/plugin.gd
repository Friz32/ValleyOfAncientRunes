tool
extends EditorPlugin

func _enter_tree():
	add_autoload_singleton("QVoxel", "res://addons/qvoxel/scripts/system.gd")

func _exit_tree():
	remove_autoload_singleton("QVoxel")
