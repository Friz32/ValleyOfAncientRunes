class_name QVoxelWorld
extends Spatial

var mesh_inst = MeshInstance.new()
var thread

func _ready():
	add_child(mesh_inst)
	
#	thread = Thread.new()
#	thread.start(self, "update_mesh")
	update_mesh()

func update_mesh():
	var chunk = QVoxelChunk.new()
	
	var noise = OpenSimplexNoise.new()
	noise.seed = randi()
	noise.octaves = 4
	noise.period = 20
	noise.persistence = 0.6
	
	for x in 16:
		for y in 32:
			for z in 16:
				if noise.get_noise_3d(x, y, z) > 0:
					chunk.data[x][y][z].type = "voar:dirt"
	
#	for x in 16:
#		for y in 32:
#			for z in 16:
#				chunk.data[x][y][z].type = "voar:dirt"
#
#	for i in 6:
#		chunk.data[8][32 + i][8].type = "voar:wood"
#
#	for x in 5:
#		for y in 5:
#			for z in 3:
#				chunk.data[8 - 2 + x][32 + 6 + z][8 - 2 + y].type = "voar:leaves"
	
	mesh_inst.mesh = ArrayMesh.new()
	chunk.create_mesh(mesh_inst.mesh)
