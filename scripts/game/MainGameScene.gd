extends Spatial

onready var camera_node = $Camera
onready var player_node = $Player
onready var follow_player_node = $FollowPlayer
onready var map_node = $Map
onready var enemy_spawner_node = $EnemySpawner
onready var path_rec = $PathRec
onready var ui = $CanvasLayer/UI
onready var time_label = $CanvasLayer/IncreaseOverTimeLabel

# 0 = setting, 1 = following
var path_state = 0

func _ready():
	get_tree().paused = false
	time_label.start(100, 0, -1, "main_time")

func _process(delta):
	pass

func _physics_process(delta):
	if path_state == 0:
		camera_node.look_at_player(player_node.translation)
		path_rec.add_player_pos(player_node.translation)
	else:
		camera_node.look_at_player(follow_player_node.translation)
		camera_node.move_towards_player_quick(follow_player_node.translation)

func _on_CameraMoveTimeout_timeout():
	if path_state == 0:
		camera_node.move_towards_player(player_node.translation)

func _on_Map_player_entered():
	path_state = 1
	player_node.queue_free()
	path_rec.get_path().append(map_node.get_end_pos())
	follow_player_node.give_path(path_rec.get_path())
	follow_player_node.visible = true
	enemy_spawner_node.start(path_rec.get_enemy_positions())
	camera_node.zoom_in()

func _on_Map_follow_entered():
	get_tree().paused = true
	ui.visible = true

func _on_FollowPlayer_death():
	get_tree().paused = true
	ui.visible = true

func _on_IncreaseOverTimeLabel_complete(string_id):
	get_tree().paused = true
	ui.visible = true
