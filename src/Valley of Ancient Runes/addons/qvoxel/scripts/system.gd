extends Node

var block := {}

func _ready():
	load_blocks()

func load_blocks():
	block.clear()
	
	QCore.foreach_file("res://addons/qvoxel/resources/blocks/", funcref(self, "load_block"))
	QCore.foreach_file(ProjectSettings.get_setting("qvoxel/blocks_path"), funcref(self, "load_block"))

func load_block(path: String):
	var res = load(path) as QVoxelBlock
	block[res.id] = res

func create_mesh_arrays():
	var arr = []
	arr.resize(Mesh.ARRAY_MAX)
	
	arr[Mesh.ARRAY_VERTEX] = PoolVector3Array()
	arr[Mesh.ARRAY_TEX_UV] = PoolVector2Array()
	arr[Mesh.ARRAY_NORMAL] = PoolVector3Array()
	arr[Mesh.ARRAY_COLOR] = PoolColorArray()
	
	return arr

func mesh_add_wall(mesh_arrays: Array, p1: Vector3, p2: Vector3, normal: Vector3):
	var verts = mesh_arrays[Mesh.ARRAY_VERTEX]
	var uvs = mesh_arrays[Mesh.ARRAY_TEX_UV]
	var normals = mesh_arrays[Mesh.ARRAY_NORMAL]
	
	verts.append(p1)
	uvs.append(Vector2(0, 0))
	normals.append(normal)
	
	verts.append(Vector3(p2.x, p1.y, p2.z))
	uvs.append(Vector2(1, 0))
	normals.append(normal)
	
	verts.append(Vector3(p1.x, p2.y, p1.z))
	uvs.append(Vector2(0, 1))
	normals.append(normal)
	
	verts.append(Vector3(p2.x, p1.y, p2.z))
	uvs.append(Vector2(1, 0))
	normals.append(normal)
	
	verts.append(p2)
	uvs.append(Vector2(1, 1))
	normals.append(normal)
	
	verts.append(Vector3(p1.x, p2.y, p1.z))
	uvs.append(Vector2(0, 1))
	normals.append(normal)

func get_voxel_size():
	return ProjectSettings.get_setting("qvoxel/voxel_size")

func get_chunk_size() -> Vector3:
	return ProjectSettings.get_setting("qvoxel/chunk_size")
