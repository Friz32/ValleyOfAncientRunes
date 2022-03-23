class_name QVoxelWorld
extends Spatial

var mesh_inst = MeshInstance.new()

func _ready():
	add_child(mesh_inst)
	
	update_mesh()

func update_mesh():
	var chunk = QVoxelChunk.new()
	for x in 16:
		for y in 32:
			for z in 16:
				chunk.data[x][y][z].type = "voar:dirt"
	
	for i in 6:
		chunk.data[8][32 + i][8].type = "voar:dirt"
	
	for x in 5:
		for y in 5:
			for z in 3:
				chunk.data[8 - 2 + x][32 + 6 + z][8 - 2 + y].type = "voar:dirt"
	
	mesh_inst.mesh = chunk.create_mesh()
