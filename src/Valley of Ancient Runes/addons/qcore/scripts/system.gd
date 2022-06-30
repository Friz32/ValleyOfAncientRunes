extends Node

func _input(event):
	if event.is_action_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen

func snap(value: float, size: float) -> float:
	return round(value / size) * size

func array_create(size := 0, fill = null) -> Array:
	var arr = []
	
	if size > 0:
		arr.resize(size)
	
	if fill != null:
		array_fill(arr, fill)
	
	return arr

func array_fill(array: Array, value, start := 0, end := 0) -> void:
	end = array.size()
	
	for i in range(start, end):
		array[i] = value

func audio_play(stream: AudioStream) -> void:
	var audio = AudioStreamPlayer.new()
	audio.stream = stream
	audio.connect("finished", self, "audio_finished", [audio])
	get_tree().root.add_child(audio)
	audio.play()

func audio_finished(node: Node) -> void:
	node.queue_free()

func foreach_file(path: String, function: FuncRef) -> void:
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var filename = dir.get_next()
		while filename != "":
			var file_path = dir.get_current_dir() + "/" + filename
			if dir.file_exists(file_path):
				function.call_funcv([file_path])
			
			filename = dir.get_next()
