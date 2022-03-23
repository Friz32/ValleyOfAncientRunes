extends Label

func _process(delta):
	var t = ""
	t += str(Engine.get_frames_per_second(), "\n")
	text = t
