extends Spatial

onready var tween = $Tween
var dir = 1

func _ready():
	tween.interpolate_property($MovSpatial, "translation:y",
		10, -10, 2,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func _on_Tween_tween_all_completed():
	if dir == 1:
		tween.interpolate_property($MovSpatial, "translation:y",
			-10, 10, 2,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
	else:
		tween.interpolate_property($MovSpatial, "translation:y",
			10, -10, 2,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
	dir *= -1
