tool
extends Node

func _ready():
	var type
	var mat
	var mat2
	
	type = QVoxelBlockType.new()
	mat = SpatialMaterial.new()
	mat.albedo_texture = load("res://textures/blocks/dirt.png")
	mat2 = SpatialMaterial.new()
	mat2.albedo_texture = load("res://textures/blocks/grass.png")
	type.cube_clear_side_material(mat)
	type.cube_side_material[Vector3.UP] = mat2
	QVoxel.block_type["voar:dirt"] = type
	
	type = QVoxelBlockType.new()
	mat = SpatialMaterial.new()
	mat.albedo_color = Color.brown
	type.cube_clear_side_material(mat)
	QVoxel.block_type["voar:wood"] = type
	
	type = QVoxelBlockType.new()
	mat = SpatialMaterial.new()
	mat.albedo_texture = load("res://textures/blocks/grass.png")
	type.cube_clear_side_material(mat)
	QVoxel.block_type["voar:leaves"] = type
	
	type = QVoxelBlockType.new()
	type.mesh_type = type.MeshType.CROSS
	mat = SpatialMaterial.new()
	mat.albedo_texture = load("res://textures/blocks/grass.png")
	type.cube_clear_side_material(mat)
	QVoxel.block_type["voar:grass"] = type
