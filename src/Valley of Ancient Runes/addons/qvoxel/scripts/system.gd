tool
extends Node

var block_type := {}

func _init():
	var type
	
	type = QVoxelBlockType.new()
	type.mesh_type = type.MeshType.VOID
	type.clear_cover(false)
	block_type["engine:none"] = type

func get_voxel_size():
	return ProjectSettings.get_setting("qvoxel/voxel_size")
