class_name Ext2DPlayer
extends Ext2DCreature

enum State {
	MOVE
	ATTACK
	ROLL
}

export var move_speed := 20.0
export var roll_speed := 30.0

onready var anim_tree = $AnimationTree
onready var anim_state: AnimationNodeStateMachinePlayback = anim_tree["parameters/playback"]
onready var hurtbox = $HurtboxPivot/Hurtbox

var state: int = State.MOVE setget set_state
var roll_vector := Vector2()

func _ready():
	anim_tree.active = true
	set_direction(Vector2(0, 1))

func _physics_process(delta):
	match state:
		State.MOVE:
			move_state()
		State.ROLL:
			roll_state()
	
	move()

func move_state():
	var input = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	
	if input != Vector2.ZERO:
		set_direction(input)
		
		anim_state.travel("move")
		
		velocity += input * move_speed
	else:
		anim_state.travel("idle")
	
	if Input.is_action_just_pressed("attack"):
		set_state(State.ATTACK)
	
	if Input.is_action_just_pressed("roll"):
		set_state(State.ROLL)

func roll_state():
	velocity += roll_vector * roll_speed

func set_state(value: int):
	state = value
	
	match state:
		State.ATTACK:
			attack()
		State.ROLL:
			roll()

func roll():
	anim_state.travel("roll")

func attack():
	anim_state.travel("attack")

func set_direction(vector: Vector2):
	anim_tree["parameters/idle/blend_position"] = vector
	anim_tree["parameters/move/blend_position"] = vector
	anim_tree["parameters/attack/blend_position"] = vector
	anim_tree["parameters/roll/blend_position"] = vector
	
	roll_vector = vector
	hurtbox.knockback_vector = vector

func attack_animation_finished():
	set_state(State.MOVE)

func roll_animation_finished():
	set_state(State.MOVE)
	velocity = Vector2.ZERO
