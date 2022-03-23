extends Node

func _ready():
	Ext3D.settings_controls_shift = "shift"
	
	var type
	
	type = QVoxelBlockType.new()
	var mat = SpatialMaterial.new()
	mat.albedo_color = Color.green
	type.cube_clear_side_material(mat)
	QVoxel.block_type["voar:dirt"] = type
