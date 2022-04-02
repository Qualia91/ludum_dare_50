extends Panel

func _on_RetryButton_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_QuitButton_pressed():
	get_tree().paused = false
	get_tree().quit()
