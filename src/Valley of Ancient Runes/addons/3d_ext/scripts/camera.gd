extends Camera

enum Mode {
	DEFAULT
	FREE
}

export(Mode) var mode: int = Mode.DEFAULT setget set_mode
export var fly_speed := 1.0 setget set_fly_speed
export var fly_speed_modifier := 0.1

func _process(delta):
	match mode:
		Mode.FREE:
			mode_free()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP:
			set_fly_speed(fly_speed + fly_speed_modifier)
		
		if event.button_index == BUTTON_WHEEL_DOWN:
			set_fly_speed(fly_speed - fly_speed_modifier)
	
	match mode:
		Mode.FREE:
			var sensitivity = Ext3D.settings_mouse_sensitivity
			
			if event is InputEventMouseMotion:
				rotation_degrees.y -= event.relative.x * sensitivity
				rotation_degrees.x = clamp(rotation_degrees.x - event.relative.y * sensitivity, -90, 90)

func mode_free():
	var input = Vector3(
		Input.get_action_strength(Ext3D.settings_controls_move_right) - Input.get_action_strength(Ext3D.settings_controls_move_left),
		Input.get_action_strength(Ext3D.settings_controls_jump) - Input.get_action_strength(Ext3D.settings_controls_shift),
		Input.get_action_strength(Ext3D.settings_controls_move_backward) - Input.get_action_strength(Ext3D.settings_controls_move_forward)
	).normalized()
	
	var basis = transform.basis
	var dir = Vector3()
	dir += basis.z * input.z
	dir += basis.x * input.x
	dir.y = input.y
	dir = dir.normalized()
	
	translation += dir * fly_speed

func set_mode(value: int):
	mode = value
	
	if value == Mode.FREE:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif mode == Mode.FREE:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func set_fly_speed(value: float):
	fly_speed = max(0, value)
