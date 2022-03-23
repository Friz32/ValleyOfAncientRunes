tool
extends EditorPlugin

func _enter_tree():
	add_autoload_singleton("Ext3D", "res://addons/3d_ext/scripts/system.gd")

func _exit_tree():
	remove_autoload_singleton("Ext3D")
