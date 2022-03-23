class_name QVoxelBlockType
extends Resource

enum MeshType {
	VOID
	CUBE
	CROSS
	WATER
	STAIRS
}

var mesh_type: int = MeshType.CUBE
var cube_side_material := []

func _init():
	cube_side_material.resize(6)

func cube_clear_side_material(mat: Material):
	for i in cube_side_material.size():
		cube_side_material[i] = mat
