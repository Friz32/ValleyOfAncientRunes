tool
class_name QVoxelWorld, "res://addons/qvoxel/textures/voxel_world_icon.png"
extends Node

export var generate_mesh := false setget set_generate_mesh

func _ready():
	if !Engine.is_editor_hint():
		var thread = Thread.new()
		thread.start(self, "generate_mesh")

func generate_mesh():
#	create_chunk()
#	create_chunk(Vector2(1, 0))
	
	var chunk = QVoxelChunk.new(Vector3(64, 32, 64))
	WorldGeneration.default(chunk, Vector2(0, 0))
	var mesh_inst = MeshInstance.new()
	mesh_inst.mesh = ArrayMesh.new()
	chunk.create_mesh(mesh_inst.mesh)
	add_child(mesh_inst)

func create_chunk(offset := Vector2(0, 0)):
	var chunk = QVoxelChunk.new()
	WorldGeneration.default(chunk, offset)
	var mesh_inst = MeshInstance.new()
	mesh_inst.translation.x = offset.x * chunk.size.x * QVoxel.get_voxel_size()
	mesh_inst.translation.z = offset.y * chunk.size.z * QVoxel.get_voxel_size()
	mesh_inst.mesh = ArrayMesh.new()
	chunk.create_mesh(mesh_inst.mesh)
	add_child(mesh_inst)

func set_generate_mesh(value):
	var thread = Thread.new()
	thread.start(self, "generate_mesh")
