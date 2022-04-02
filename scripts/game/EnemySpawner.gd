extends Spatial

onready var enemy_scene = load("res://scenes/game/enemies/Enemy1.tscn")
onready var bullet_scene = load("res://scenes/game/enemies/Bullet.tscn")

var enemies = []
var bullets = []

var enemy_number
var bullet_number = 20

var current_enemy_number = 0
var current_bullet_number = 0

export var speed = 10

var start = false

func _ready():
	for _i in range(bullet_number):
		var inst = bullet_scene.instance()
		add_child(inst)
		inst.translate(Vector3(0, 0, 100))
		bullets.append(inst)

func start(enemy_positions):
	enemy_number = enemy_positions.size()
	for pos in enemy_positions:
		var inst = enemy_scene.instance()
		add_child(inst)
		inst.translate(pos)
		inst.connect("shoot", self, "_on_Shoot")
		enemies.append(inst)

func _on_Shoot(start_pos):
	bullets[current_bullet_number].shoot(start_pos)
	current_bullet_number = (current_bullet_number + 1) % bullet_number
	
