class_name WorldGeneration

static func tree(chunk: QVoxelChunk):
	var size = chunk.size
	
	for x in size.x:
		for y in 32:
			for z in size.z:
				chunk.data[x][y][z].type = "voar:dirt"

	for i in 6:
		chunk.data[8][32 + i][8].type = "voar:wood"

	for x in 5:
		for y in 5:
			for z in 3:
				chunk.data[8 - 2 + x][32 + 6 + z][8 - 2 + y].type = "voar:leaves"

static func wave(chunk: QVoxelChunk, offset: Vector2):
	var size = chunk.size
	
	for x in size.x:
		for z in size.z:
			for y in 10 + ((2 * sin(x + offset.x * size.x)) + (2 * cos(z + offset.y * size.z))):
				chunk.data[x][y][z].type = "voar:dirt"

static func default(chunk: QVoxelChunk, offset: Vector2):
	var size = chunk.size
	
	var noise = OpenSimplexNoise.new()
	noise.seed = 0
	noise.octaves = 4
	noise.period = 50
	noise.persistence = 0.6
	
	for x in size.x:
		for z in size.z:
			var h = noise.get_noise_2d(x + offset.x * size.x, z + offset.y * size.y)
			for y in 4 + 16 * h:
				chunk.data[x][y][z].type = "voar:dirt"