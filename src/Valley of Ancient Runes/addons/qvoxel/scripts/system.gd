extends Node

const VOXEL_SIZE = 16

var block_type := {}

func _init():
	var type
	
	type = QVoxelBlockType.new()
	type.mesh_type = type.MeshType.VOID
	block_type["engine:none"] = type
