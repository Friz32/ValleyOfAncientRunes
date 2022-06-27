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
	var surface = {}
	
	for x in size.x:
		for y in size.y:
			for z in size.z:
				var block_type = QVoxel.block_type[data[x][y][z].type]
				
				match block_type.mesh_type:
					QVoxelBlockType.MeshType.CUBE:
						mesh_add_cube(surface, block_type, Vector3(x, y, z) * QVoxel.voxel_size)
	
	var i = 0
	for mat in surface:
		mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, surface[mat])
		mesh.surface_set_material(i, mat)
		i += 1

func mesh_add_cube(surface: Dictionary, block_type: QVoxelBlockType, pos: Vector3):
	var s = QVoxel.voxel_size
	var x = pos.x
	var y = pos.y
	var z = pos.z
	var block_x = x / s
	var block_y = y / s
	var block_z = z / s
	var arrays
	
	# +X
	if block_x + 1 < size.x && !QVoxel.block_type[data[block_x + 1][block_y][block_z].type].cover[Vector3.LEFT]:
		arrays = surface.get(block_type.cube_side_material[Vector3.RIGHT], null)
		if arrays == null:
			arrays = create_mesh_arrays()
			surface[block_type.cube_side_material[Vector3.RIGHT]] = arrays
		
		mesh_add_face(
			arrays, Vector3.RIGHT,
			Vector3(x + s, y + s, z + s),
			Vector3(x + s, y + s, z),
			Vector3(x + s, y, z + s),
			Vector3(x + s, y, z)
		)
	
	# -X
	if block_x - 1 > 0 && !QVoxel.block_type[data[block_x - 1][block_y][block_z].type].cover[Vector3.RIGHT]:
		arrays = surface.get(block_type.cube_side_material[Vector3.LEFT], null)
		if arrays == null:
			arrays = create_mesh_arrays()
			surface[block_type.cube_side_material[Vector3.LEFT]] = arrays
		
		mesh_add_face(
			arrays, Vector3.LEFT,
			Vector3(x, y + s, z),
			Vector3(x, y + s, z + s),
			Vector3(x, y, z),
			Vector3(x, y, z + s)
		)
	
	# +Z
	if block_z + 1 < size.z && !QVoxel.block_type[data[block_x][block_y][block_z + 1].type].cover[Vector3.FORWARD]:
		arrays = surface.get(block_type.cube_side_material[Vector3.BACK], null)
		if arrays == null:
			arrays = create_mesh_arrays()
			surface[block_type.cube_side_material[Vector3.BACK]] = arrays
		
		mesh_add_face(
			arrays, Vector3.BACK,
			Vector3(x, y + s, z + s),
			Vector3(x + s, y + s, z + s),
			Vector3(x, y, z + s),
			Vector3(x + s, y, z + s)
		)
	
	# -Z
	if block_z - 1 > 0 && !QVoxel.block_type[data[block_x][block_y][block_z - 1].type].cover[Vector3.BACK]:
		arrays = surface.get(block_type.cube_side_material[Vector3.FORWARD], null)
		if arrays == null:
			arrays = create_mesh_arrays()
			surface[block_type.cube_side_material[Vector3.FORWARD]] = arrays
		
		mesh_add_face(
			arrays, Vector3.FORWARD,
			Vector3(x + s, y + s, z),
			Vector3(x, y + s, z),
			Vector3(x + s, y, z),
			Vector3(x, y, z)
		)
	
	# +Y
	if block_y + 1 < size.y && !QVoxel.block_type[data[block_x][block_y + 1][block_z].type].cover[Vector3.DOWN]:
		arrays = surface.get(block_type.cube_side_material[Vector3.UP], null)
		if arrays == null:
			arrays = create_mesh_arrays()
			surface[block_type.cube_side_material[Vector3.UP]] = arrays
		
		mesh_add_face(
			arrays, Vector3.UP,
			Vector3(x, y + s, z + s),
			Vector3(x, y + s, z),
			Vector3(x + s, y + s, z + s),
			Vector3(x + s, y + s, z)
		)
	
	# -Y
	if block_y - 1 > 0 && !QVoxel.block_type[data[block_x][block_y - 1][block_z].type].cover[Vector3.UP]:
		arrays = surface.get(block_type.cube_side_material[Vector3.DOWN], null)
		if arrays == null:
			arrays = create_mesh_arrays()
			surface[block_type.cube_side_material[Vector3.DOWN]] = arrays
		
		mesh_add_face(
			arrays, Vector3.DOWN,
			Vector3(x + s, y, z + s),
			Vector3(x + s, y, z),
			Vector3(x, y, z + s),
			Vector3(x, y, z)
		)

func create_mesh_arrays():
	var arr = []
	arr.resize(Mesh.ARRAY_MAX)
	
	var verts = PoolVector3Array()
	var uvs = PoolVector2Array()
	var normals = PoolVector3Array()
	
	arr[Mesh.ARRAY_VERTEX] = verts
	arr[Mesh.ARRAY_TEX_UV] = uvs
	arr[Mesh.ARRAY_NORMAL] = normals
	
	return arr

func mesh_add_face(mesh_arrays: Array, normal: Vector3, p1, p2, p3, p4):
	var verts = mesh_arrays[Mesh.ARRAY_VERTEX]
	var uvs = mesh_arrays[Mesh.ARRAY_TEX_UV]
	var normals = mesh_arrays[Mesh.ARRAY_NORMAL]
	
	verts.append(p1)
	uvs.append(Vector2(0, 0))
	normals.append(normal)
	
	verts.append(p2)
	uvs.append(Vector2(1, 0))
	normals.append(normal)
	
	verts.append(p3)
	uvs.append(Vector2(0, 1))
	normals.append(normal)
	
	verts.append(p2)
	uvs.append(Vector2(1, 0))
	normals.append(normal)
	
	verts.append(p4)
	uvs.append(Vector2(1, 1))
	normals.append(normal)
	
	verts.append(p3)
	uvs.append(Vector2(0, 1))
	normals.append(normal)
	
	mesh_arrays[Mesh.ARRAY_VERTEX] = verts
	mesh_arrays[Mesh.ARRAY_TEX_UV] = uvs
	mesh_arrays[Mesh.ARRAY_NORMAL] = normals
