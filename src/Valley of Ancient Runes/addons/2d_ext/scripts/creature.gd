class_name Ext2DCreature
extends Ext2DEntity

export var max_health := 1

onready var health := max_health setget set_health

func set_health(value):
	health = value
	
	if health < 1:
		death()

func death():
	queue_free()
