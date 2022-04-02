extends StaticBody

signal player_entered
signal follow_entered

func _ready():
	pass # Replace with function body.

func _on_Area_body_entered(body):
	if body.name == "Player":
		emit_signal("player_entered")
	elif body.name == "FollowPlayer":
		emit_signal("follow_entered")

func get_end_pos():
	return $Area.translation + translation
