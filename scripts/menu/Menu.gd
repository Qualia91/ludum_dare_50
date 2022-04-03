extends Node2D

onready var tween = $Tween
onready var menu_node = $Menus
onready var volume_slider = $Menus/offset/Settings/Volume/VolumeSlide
onready var windowed_button = $Menus/offset/Settings/WindowedButton
onready var level_container = $Menus/offset/LevelSelect/ScrollContainer/LevelContainer

const IOClass = preload("res://scripts/objects/IO.gd")
onready var IO = IOClass.new()
onready var save_data = IO.load_data("user://save_data.json")

var level_card = load("res://scenes/menu/LevelSelectItem.tscn")

onready var jump_noises = [
	$Jump1,
	$Jump2,
	$Jump3,
	$Jump4,
	$Jump5,
	$Jump6,
	$Jump7
]

func _process(delta):
	
	var texture = $Viewport.get_texture()
	$Screen.texture = texture

func _ready():
		
	volume_slider.value = save_data["volume"]
		
	if save_data["fullscreen"]:
		windowed_button.text = "Switch to Windowed"
	else:
		windowed_button.text = "Switch to Fullscreen"
	
	menu_node.position = Global.menu_pos
	
	var index = 0
	for unlocked in save_data["levels_unlocked"]:
		var inst = level_card.instance()
		level_container.add_child(inst)
		inst.init(index, unlocked, save_data["level_times"][index])
		index += 1
	

func tween_trans(start_pos, end_pos):
	jump_noises[Global.rng.randi_range(0, jump_noises.size() - 1)].playing = true
	tween.interpolate_property(menu_node, "position",
		start_pos, end_pos, 0.3,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	Global.menu_pos = end_pos
	tween.start()

func _on_VolumeSlide_value_changed(value):
	jump_noises[Global.rng.randi_range(0, jump_noises.size() - 1)].playing = true
	save_data["volume"] = value
	IO.save_data("user://save_data.json", save_data)
	if value == -20:
		AudioServer.set_bus_mute(0, true)
	else:
		AudioServer.set_bus_mute(0, false)
		AudioServer.set_bus_volume_db(0, value)

func _on_PlayButton_pressed():
	Global.level = 0
	get_tree().change_scene("res://scenes/game/MainGameScene.tscn")

func _on_LevelSelectButton_pressed():
	tween_trans(Vector2(0, 0), Vector2(-2000, 0))

func _on_SettingsButton_pressed():
	tween_trans(Vector2(0, 0), Vector2(2000, 0))

func _on_WindowedButton_pressed():
	jump_noises[Global.rng.randi_range(0, jump_noises.size() - 1)].playing = true
	save_data["fullscreen"] = !save_data["fullscreen"]
	OS.window_fullscreen = save_data["fullscreen"]
	IO.save_data("user://save_data.json", save_data)
	if save_data["fullscreen"]:
		windowed_button.text = "Switch to Windowed"
	else:
		windowed_button.text = "Switch to Fullscreen"

func _on_SettingsBackButton_pressed():
	tween_trans(Vector2(2000, 0), Vector2(0, 0))

func _on_LevelSelectBackButton_pressed():
	tween_trans(Vector2(-2000, 0), Vector2(0, 0))
	
func _on_HowToBackButton_pressed():
	tween_trans(Vector2(0, -2000), Vector2(0, 0))

func _on_HowToPlayButton_pressed():
	tween_trans(Vector2(0, 0), Vector2(0, -2000))

func _on_QuitButton_pressed():
	$HitNoise.playing = true

func _on_HitNoise_finished():
	get_tree().quit()
