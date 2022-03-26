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
var cover := {}
var cube_side_material := {}

func _init():
	clear_cover(true)
	cube_clear_side_material(null)

func clear_cover(value: bool):
	cover[Vector3.FORWARD] = value
	cover[Vector3.BACK] = value
	cover[Vector3.UP] = value
	cover[Vector3.DOWN] = value
	cover[Vector3.RIGHT] = value
	cover[Vector3.LEFT] = value

func cube_clear_side_material(mat: Material):
	cube_side_material[Vector3.FORWARD] = mat
	cube_side_material[Vector3.BACK] = mat
	cube_side_material[Vector3.UP] = mat
	cube_side_material[Vector3.DOWN] = mat
	cube_side_material[Vector3.RIGHT] = mat
	cube_side_material[Vector3.LEFT] = mat
