extends Panel

func start(complete):
	get_tree().paused = true
	visible = true
	if complete:
		$VBoxContainer/NextLevelButton.visible = true

func _on_RetryButton_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_QuitButton_pressed():
	get_tree().paused = false
	get_tree().quit()

func _on_NextLevelButton_pressed():
	Global.level += 1
	get_tree().paused = false
	get_tree().reload_current_scene()
