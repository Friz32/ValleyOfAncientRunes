extends Label

func _process(delta):
	var data = ""
	data += "FPS: %s\n" % Engine.get_frames_per_second()
	
	text = data
