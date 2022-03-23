extends Ext3DEntity

onready var camera = $Camera

func _ready():
	$EditorIcon.queue_free()
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	movement()

func _input(event):
	camera_control(event)

func camera_control(event: InputEvent):
	var sensitivity = Ext3D.settings_mouse_sensitivity
	
	if event is InputEventMouseMotion:
		camera.rotation_degrees.y -= event.relative.x * sensitivity
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x - event.relative.y * sensitivity, -90, 90)

func movement():
	var input = Vector2(
		Input.get_action_strength(Ext3D.settings_controls_move_right) - Input.get_action_strength(Ext3D.settings_controls_move_left),
		Input.get_action_strength(Ext3D.settings_controls_move_backward) - Input.get_action_strength(Ext3D.settings_controls_move_forward)
	).normalized()
	
	var basis = camera.global_transform.basis
	var dir = Vector3()
	dir += basis.z * input.y * 4
	dir += basis.x * input.x * 4
	dir.y = 0
	dir = dir.normalized()
	velocity += dir
	
	velocity = move_and_slide(velocity)
	velocity = velocity.linear_interpolate(Vector3.ZERO, 0.1)
