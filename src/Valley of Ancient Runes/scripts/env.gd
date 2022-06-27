tool
extends WorldEnvironment

onready var dir_light = $DirectionalLight

func _process(delta):
	if environment.background_sky is ProceduralSky && dir_light != null:
		dir_light.rotation_degrees.x = -environment.background_sky.sun_latitude
		dir_light.rotation_degrees.y = 180 - environment.background_sky.sun_longitude
