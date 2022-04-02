extends Spatial

signal player_entered
signal follow_entered

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_End_player_entered():
	emit_signal("player_entered")

func _on_End_follow_entered():
	emit_signal("follow_entered")

func get_end_pos():
	return $End.get_end_pos()
