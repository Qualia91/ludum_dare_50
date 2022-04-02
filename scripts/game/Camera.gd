extends Spatial

onready var camera_node = $Camera
onready var tween = $Tween

var UP = Vector3(0, 1, 0)

var y_diff = 15

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func zoom_in():
	y_diff = 6
	camera_node.translation.z = 15

func look_at_player(pos):
	camera_node.look_at(pos, UP)

func move_towards_player_quick(player_pos):
	var current_x = camera_node.translation.x
	tween.interpolate_property(camera_node, "translation:x",
		current_x, player_pos.x, 0.02,
		Tween.TRANS_LINEAR)
	var current_y = camera_node.translation.y
	tween.interpolate_property(camera_node, "translation:y",
		current_y, player_pos.y + y_diff, 0.02,
		Tween.TRANS_LINEAR)
	tween.start()
	
func move_towards_player(player_pos):
	var current_x = camera_node.translation.x
	tween.interpolate_property(camera_node, "translation:x",
		current_x, player_pos.x, 0.5,
		Tween.TRANS_LINEAR)
	var current_y = camera_node.translation.y
	tween.interpolate_property(camera_node, "translation:y",
		current_y, player_pos.y + y_diff, 0.5,
		Tween.TRANS_LINEAR)
	tween.start()
