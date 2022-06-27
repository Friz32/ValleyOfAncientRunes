tool
class_name QVoxelBlockDB
extends Resource

export var id = {}
export var block = {}
export var size := 0 setget set_size

func _get_property_list():
	var arr = []
	
	for i in size:
		arr.append({name = str(i, "/id"), type = TYPE_STRING})
		arr.append({name = str(i, "/block"), type = TYPE_OBJECT, hint = PROPERTY_HINT_RESOURCE_TYPE, hint_string = "QVoxelBlockType"})
	
	return arr

func _set(property, value):
	for i in size:
		if property == str(i, "/id"):
			id[i] = value
		
		if property == str(i, "/block"):
			block[i] = value

func _get(property):
	for i in size:
		if property == str(i, "/id"):
			return id[i]
		
		if property == str(i, "/block"):
			return block[i]

func set_size(value):
	size = value
	property_list_changed_notify()
