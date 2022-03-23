extends Ext2DAI

func _physics_process(delta):
	move()

func death():
	.death()
	
	var node = System.get_res("scn_fx_explosion").instance()
	get_parent().add_child(node)
	node.position = position
	node.position.y -= 8

func on_hit(knockback_vector, damage):
	velocity += knockback_vector * 300
	set_health(health - damage)
