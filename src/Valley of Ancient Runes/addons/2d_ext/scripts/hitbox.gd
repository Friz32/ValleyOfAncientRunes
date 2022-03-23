class_name Ext2DHitbox
extends Area2D

signal hit(knockback_vector, damage)

export var show_hit := true

func on_hit(knockback_vector, damage):
	if show_hit:
		var node = System.get_res("scn_fx_hit").instance()
		get_tree().root.add_child(node)
		node.global_position = global_position + Vector2(0, -8)
