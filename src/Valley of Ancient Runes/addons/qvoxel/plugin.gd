tool
extends EditorPlugin

func _enter_tree():
	add_autoload_singleton("QVoxel", "res://addons/qvoxel/scripts/system.gd")
	
	if !ProjectSettings.has_setting("qvoxel/voxel_size"):
		ProjectSettings.set_setting("qvoxel/voxel_size", 2)
		ProjectSettings.set_initial_value("qvoxel/voxel_size", 2)
	
	if !ProjectSettings.has_setting("qvoxel/chunk_size"):
		ProjectSettings.set_setting("qvoxel/chunk_size", Vector3(16, 256, 16))
		ProjectSettings.set_initial_value("qvoxel/chunk_size", Vector3(16, 256, 16))
	
	if !ProjectSettings.has_setting("qvoxel/blocks_path"):
		ProjectSettings.set_setting("qvoxel/blocks_path", "res://blocks")
		ProjectSettings.set_initial_value("qvoxel/blocks_path", "res://blocks")

func _exit_tree():
	remove_autoload_singleton("QVoxel")
	
	ProjectSettings.set_setting("qvoxel/voxel_size", null)
	ProjectSettings.set_setting("qvoxel/chunk_size", null)
	ProjectSettings.set_setting("qvoxel/blocks_path", null)
