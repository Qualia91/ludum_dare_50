extends Panel

const IOClass = preload("res://scripts/objects/IO.gd")
onready var IO = IOClass.new()

func completed(time, message):
	$WinNoise.play()
	get_tree().paused = true
	visible = true
	$VBoxContainer/Title.text = message
	$VBoxContainer/NextLevelButton.visible = true
	$VBoxContainer/TimeLabel.text = "Time: " + str(time)
	
	var save_data = IO.load_data("user://save_data.json")
	
	save_data["levels_unlocked"][Global.level] = true
	
	if save_data["level_times"][Global.level] == -1:
		save_data["level_times"][Global.level] = time
	elif save_data["level_times"][Global.level] :
		save_data["level_times"][Global.level] = time
	
	IO.save_data("user://save_data.json", save_data)

func failed(message):
	$HitNoise.play()
	get_tree().paused = true
	$VBoxContainer/Title.text = message
	visible = true

func _on_RetryButton_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_QuitButton_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://scenes/menu/Menu.tscn")

func _on_NextLevelButton_pressed():
	Global.level += 1
	get_tree().paused = false
	get_tree().reload_current_scene()
