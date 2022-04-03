extends Node2D

# Version tag: This needs to be changed every time the player_data format
# is changed, to replace the current user data
var current_version_string = "0.0.1"

const IOClass = preload("res://scripts/objects/IO.gd")
onready var IO = IOClass.new()

var save_data
var first_time = false

func _process(delta):
	
	var texture = $Viewport.get_texture()
	$Screen.texture = texture

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# if file exists, user files are init, so dont init them
	if not IO.does_file_exist("user://save_data.json"):
		var save_data = IO.load_data_unencrypted("res://data/save_data.json")
		IO.save_data("user://save_data.json", save_data)
		first_time = true
		
	# check if player data is on the correct version
	var current_save_data = IO.load_data("user://save_data.json")
	
	# if it doesnt have a version string, overwrite 
	if not current_save_data.has("version"):
		var save_data = IO.load_data("res://data/save_data.json")
		IO.save_data("user://save_data.json", save_data)
	
	# if the version is different, update data
	# TODO
	if current_save_data.has("version") and current_save_data["version"] != current_version_string:
		var old_save_data = IO.load_data("user://save_data.json")
		var new_save_data = IO.load_data("res://data/save_data.json")
		IO.save_data("user://save_data.json", new_save_data)

	self.save_data = IO.load_data("user://save_data.json")
	
	OS.window_fullscreen = save_data["fullscreen"]
	
	if save_data["volume"] == -20:
		AudioServer.set_bus_mute(0, true)
	else:
		AudioServer.set_bus_mute(0, false)
		AudioServer.set_bus_volume_db(0, save_data["volume"])

func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://scenes/menu/Menu.tscn")
