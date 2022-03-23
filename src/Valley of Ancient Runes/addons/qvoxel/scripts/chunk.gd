class_name QVoxelChunk
extends Resource

var data: Array
var size: Vector3

func _init(size := Vector3(16, 256, 16)):
	self.size = size
	
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

func create_mesh(mesh: ArrayMesh):
	var arr = []
	arr.resize(Mesh.ARRAY_MAX)
	
	var verts = PoolVector3Array()
	var uvs = PoolVector2Array()
	var normals = PoolVector3Array()
	
	arr[Mesh.ARRAY_VERTEX] = verts
	arr[Mesh.ARRAY_TEX_UV] = uvs
	arr[Mesh.ARRAY_NORMAL] = normals
	
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arr)
	
#	var s = QVoxel.VOXEL_SIZE
#	var st = SurfaceTool.new()
#	st.begin(Mesh.PRIMITIVE_TRIANGLES)
#	st.add_color(Color.white)
#
#	for x in size.x:
#		for y in size.y:
#			for z in size.z:
#				match QVoxel.block_type[data[x][y][z].type].mesh_type:
#					QVoxelBlockType.MeshType.CUBE:
#						st_add_cube(st, Vector3(x, y, z) * s)
#
#	return st.commit()

func st_add_face(st: SurfaceTool, normal, p1, p2, p3, p4):
	st.add_normal(normal)
	
	st.add_uv(Vector2(0, 0))
	st.add_vertex(p1)
	st.add_uv(Vector2(1, 0))
	st.add_vertex(p2)
	st.add_uv(Vector2(0, 1))
	st.add_vertex(p3)
	
	st.add_uv(Vector2(1, 0))
	st.add_vertex(p2)
	st.add_uv(Vector2(1, 1))
	st.add_vertex(p4)
	st.add_uv(Vector2(0, 1))
	st.add_vertex(p3)

func st_add_cube(st: SurfaceTool, pos: Vector3):
	var s = QVoxel.VOXEL_SIZE
	var x = pos.x
	var y = pos.y
	var z = pos.z
	
	# +X
	st_add_face(
		st, Vector3.RIGHT,
		Vector3(x + s, y + s, z + s),
		Vector3(x + s, y + s, z),
		Vector3(x + s, y, z + s),
		Vector3(x + s, y, z)
	)
	
	# -X
	st_add_face(
		st, Vector3.LEFT,
		Vector3(x, y + s, z),
		Vector3(x, y + s, z + s),
		Vector3(x, y, z),
		Vector3(x, y, z + s)
	)

	# +Z
	st_add_face(
		st, Vector3.BACK,
		Vector3(x, y + s, z + s),
		Vector3(x + s, y + s, z + s),
		Vector3(x, y, z + s),
		Vector3(x + s, y, z + s)
	)

	# -Z
	st_add_face(
		st, Vector3.FORWARD,
		Vector3(x + s, y + s, z),
		Vector3(x, y + s, z),
		Vector3(x + s, y, z),
		Vector3(x, y, z)
	)

	# +Y
	st_add_face(
		st, Vector3.UP,
		Vector3(x, y + s, z + s),
		Vector3(x, y + s, z),
		Vector3(x + s, y + s, z + s),
		Vector3(x + s, y + s, z)
	)

	# -Y
	st_add_face(
		st, Vector3.DOWN,
		Vector3(x + s, y, z + s),
		Vector3(x + s, y, z),
		Vector3(x, y, z + s),
		Vector3(x, y, z)
	)
