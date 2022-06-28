tool
extends Node

func _ready():
	var type
	var mat
	var mat2
	
	type = QVoxelBlockType.new()
	type.cube_clear_side_material(preload("res://resources/materials/dirt.tres"))
	QVoxel.block_type["voar:dirt"] = type
	
	type = QVoxelBlockType.new()
	type.cube_clear_side_material(preload("res://resources/materials/grass_block_side.tres"))
	type.cube_side_material[Vector3.UP] = preload("res://resources/materials/grass_block.tres")
	type.cube_side_material[Vector3.DOWN] = preload("res://resources/materials/dirt.tres")
	QVoxel.block_type["voar:grass_block"] = type
	
	type = QVoxelBlockType.new()
	mat = SpatialMaterial.new()
	mat.albedo_color = Color.brown
	type.cube_clear_side_material(mat)
	QVoxel.block_type["voar:wood"] = type
	
	type = QVoxelBlockType.new()
	mat = SpatialMaterial.new()
	mat.albedo_texture = preload("res://textures/blocks/grass_block.png")
	type.cube_clear_side_material(mat)
	QVoxel.block_type["voar:leaves"] = type
	
#	type = QVoxelBlockType.new()
#	type.mesh_type = type.MeshType.CROSS
#	mat = SpatialMaterial.new()
#	mat.albedo_texture = preload("res://textures/blocks/grass.png")
#	type.cube_clear_side_material(mat)
#	QVoxel.block_type["voar:grass"] = type
