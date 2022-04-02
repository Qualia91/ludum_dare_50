extends Spatial

onready var levels = [
	load("res://scenes/game/levels/Level1.tscn"),
	load("res://scenes/game/levels/Level2.tscn"),
	load("res://scenes/game/levels/Level3.tscn"),
	load("res://scenes/game/levels/Level4.tscn"),
	load("res://scenes/game/levels/Level5.tscn"),
	load("res://scenes/game/levels/Level6.tscn"),
	load("res://scenes/game/levels/Level7.tscn"),
	load("res://scenes/game/levels/Level8.tscn")
]

onready var camera_node = $Camera
onready var player_node = $Player
onready var follow_player_node = $FollowPlayer
onready var enemy_spawner_node = $EnemySpawner
onready var path_rec = $PathRec
onready var ui = $CanvasLayer/UI
onready var time_label = $CanvasLayer/IncreaseOverTimeLabel

var map_node
var time_taken = 0

# 0 = setting, 1 = following
var path_state = 0

func _ready():
	
	Global.rng.randomize()
	
	get_tree().paused = false
	time_label.start(30, 0, -1, "main_time")
	
	var level_scene = levels[0]
	if Global.level < levels.size():
		level_scene = levels[Global.level]
	
	map_node = level_scene.instance()
	add_child(map_node)
	
	map_node.connect("player_entered", self, "_on_Map_player_entered")
	map_node.connect("follow_entered", self, "_on_Map_follow_entered")

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
	camera_node.look_at_player(Vector3(0, 0, 0))
	path_rec.add_player_pos(map_node.get_end_pos())
	path_state = 1
	player_node.queue_free()
	path_rec.get_path().append(map_node.get_end_pos())
	follow_player_node.give_path(path_rec.get_path())
	follow_player_node.visible = true
	enemy_spawner_node.start(path_rec.get_enemy_positions())
	camera_node.zoom_in()
	time_label.stop()
	$CanvasLayer/TimeLabel.text = "0"
	time_taken = 0
	$Timer.start()

func _on_Map_follow_entered():
	ui.start(true)

func _on_FollowPlayer_death():
	ui.start(false)

func _on_IncreaseOverTimeLabel_complete(string_id):
	ui.start(false)

func _on_Player_death():
	ui.start(false)

func _on_Timer_timeout():
	time_taken += 1
	$CanvasLayer/TimeLabel.text = str(time_taken)

func _on_RestartButton_pressed():
	ui.start(false)
