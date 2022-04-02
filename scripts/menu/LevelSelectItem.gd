extends Panel

var level

func init(level, unlocked, best_score):
	self.level = level
	$MainHBox/Button.disabled = not unlocked
	$MainHBox/Button.text = str(level)
	if best_score == -1:
		$MainHBox/BestTime.text = "--"
	else:
		$MainHBox/BestTime.text = str(best_score)

func _on_Button_pressed():
	Global.level = self.level
	get_tree().change_scene("res://scenes/game/MainGameScene.tscn")
