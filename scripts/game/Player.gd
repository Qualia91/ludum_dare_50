extends KinematicBody

signal death

export var gravity = Vector3.DOWN * 10
export var speed = 1.5
export var jump_speed = 100
export var max_jump = 50
export var slow_down = 1.05

onready var jump_noises = [
	$Jump1,
	$Jump2,
	$Jump3,
	$Jump4,
	$Jump5,
	$Jump6,
	$Jump7
]

var velocity = Vector3(10, 0, 0)
var double_jump_active = 0

var on_floor = false

var end_pos

func start(end_pos):
	pass

func _ready():
	move_lock_z = true

func _physics_process(delta):
	
	if !is_on_floor():
		velocity += gravity * delta
	else:
		double_jump_active = 0
	get_input(delta)
	velocity = move_and_slide(velocity, Vector3.UP)

func get_input(delta):
	
	if abs(velocity.x) > 1:
		velocity.x /= slow_down
	else:
		velocity.x = 0
	
	if is_on_floor() and Input.is_action_pressed("up"):
		velocity.y += jump_speed
		jump_noises[Global.rng.randi_range(0, jump_noises.size() - 1)].playing = true
	elif double_jump_active == 1 and not is_on_floor() and Input.is_action_pressed("up"):
		double_jump_active = 2
		velocity.y += jump_speed
		jump_noises[Global.rng.randi_range(0, jump_noises.size() - 1)].playing = true
	if Input.is_action_pressed("right"):
		velocity.x += speed
	if Input.is_action_pressed("left"):
		velocity.x += -speed
	
	velocity.y = min(velocity.y, max_jump)

func _input(event):
	if double_jump_active == 0 and Input.is_action_just_released("up"):
		double_jump_active = 1

func death():
	emit_signal("death")
