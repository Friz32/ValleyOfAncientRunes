class_name QVoxelChunk
extends Spatial

onready var mesh_inst := $MeshInstance

var data

func _ready():
	var size = QVoxel.get_chunk_size()
	data = []
	data.resize(size.x)
	for x in size.x:
		data[x] = []
		data[x].resize(size.y)
		for y in size.y:
			data[x][y] = []
			data[x][y].resize(size.z)
			for z in size.z:
				data[x][y][z] = QVoxelBlockData.new()
	
	generate_mesh()

func generate_mesh():
	mesh_inst.mesh.clear_surfaces()
	
	var size = QVoxel.get_chunk_size()
	var arrays = {}
	for x in size.x:
		for y in size.y:
			for z in size.z:
				var block = QVoxel.block[data[x][y][z].id]
				block.mesh(arrays, Vector3(x, y, z))

	for i in arrays.size():
		mesh_inst.mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays.values()[i])
		mesh_inst.mesh.surface_set_material(i, arrays.keys()[i])
