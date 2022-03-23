extends Node

const PATH = "user://settings.cfg"

var fullscreen := true setget set_fullscreen

func _ready():
	var file = File.new()
	
	if !file.file_exists(PATH):
		save_to_file()
	
	load_from_file()

func save_to_file():
	var config = ConfigFile.new()
	config.set_value("general", "fullscreen", fullscreen)
	config.save(PATH)

func load_from_file():
	var config = ConfigFile.new()
	var err = config.load(PATH)
	
	if err != OK:
		return
	
	set_fullscreen(config.get_value("general", "fullscreen", fullscreen))

func set_fullscreen(value: bool):
	OS.window_fullscreen = value
