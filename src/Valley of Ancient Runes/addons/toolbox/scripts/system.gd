extends Node

var restart_game := funcref(self, "restart_game_default")

func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("change_fullscreen"):
			OS.window_fullscreen = !OS.window_fullscreen
		
		if OS.is_debug_build():
			# Быстрый выход из игры
			if event.scancode == KEY_ESCAPE:
				get_tree().quit()
			
			if event.control:
				# Перезагрузка сцены
				if event.scancode == KEY_S:
					get_tree().reload_current_scene()
				
				# Перезапустить игру
				if event.scancode == KEY_R:
					restart_game.call_func()

func restart_game_default():
	get_tree().change_scene(ProjectSettings["application/run/main_scene"])

func snap(value, size):
	return round(value / size) * size

func play_audio(stream: AudioStream):
	var audio = AudioStreamPlayer.new()
	audio.stream = stream
	audio.play()
	audio.connect("finished", self, "on_audio_finished", [audio])
	
	get_tree().root.add_child(audio)

func on_audio_finished(node):
	node.queue_free()
