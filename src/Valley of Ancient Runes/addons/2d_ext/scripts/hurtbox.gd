class_name Ext2DHurtbox
extends Area2D

export var damage := 1

var knockback_vector := Vector2()

func on_area_entered(area):
	if area is Ext2DHitbox:
		area.emit_signal("hit", knockback_vector, damage)
