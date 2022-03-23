tool
extends WorldEnvironment

onready var dir_light = $DirectionalLight

func _process(delta):
	if dir_light != null:
		dir_light.rotation_degrees = Vector3(
			-environment.background_sky.sun_latitude,
			180 - environment.background_sky.sun_longitude,
			0
		)
