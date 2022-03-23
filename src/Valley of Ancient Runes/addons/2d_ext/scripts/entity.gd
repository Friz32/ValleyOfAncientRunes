class_name Ext2DEntity
extends KinematicBody2D

export var deceleration := 0.2

var velocity := Vector2()

func _physics_process(delta):
	move()

func move():
	velocity = move_and_slide(velocity)
	
	velocity = velocity.linear_interpolate(Vector2.ZERO, deceleration)
