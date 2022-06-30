tool
class_name QVoxelBlockCube
extends QVoxelBlock

export var init := false setget set_init

var material_left
var material_right
var material_top
var material_bottom
var material_front
var material_back

func _get_property_list():
	var arr = []
	
	arr.append({name = "materials", type = TYPE_NIL, usage = PROPERTY_USAGE_GROUP, hint_string = "material_"})
	arr.append({name = "material_left", type = TYPE_OBJECT, hint = PROPERTY_HINT_RESOURCE_TYPE, hint_string = "SpatialMaterial,ShaderMaterial"})
	arr.append({name = "material_right", type = TYPE_OBJECT, hint = PROPERTY_HINT_RESOURCE_TYPE, hint_string = "SpatialMaterial,ShaderMaterial"})
	arr.append({name = "material_top", type = TYPE_OBJECT, hint = PROPERTY_HINT_RESOURCE_TYPE, hint_string = "SpatialMaterial,ShaderMaterial"})
	arr.append({name = "material_bottom", type = TYPE_OBJECT, hint = PROPERTY_HINT_RESOURCE_TYPE, hint_string = "SpatialMaterial,ShaderMaterial"})
	arr.append({name = "material_front", type = TYPE_OBJECT, hint = PROPERTY_HINT_RESOURCE_TYPE, hint_string = "SpatialMaterial,ShaderMaterial"})
	arr.append({name = "material_back", type = TYPE_OBJECT, hint = PROPERTY_HINT_RESOURCE_TYPE, hint_string = "SpatialMaterial,ShaderMaterial"})
	
	return arr

func mesh(arrays: Dictionary, pos: Vector3):
	var s = QVoxel.get_voxel_size()
	var x = pos.x * s
	var y = pos.y * s
	var z = pos.z * s

func set_init(value):
	full_side = FULL_SIDE_ALL
	property_list_changed_notify()
