extends KinematicBody

signal death

export var gravity = Vector3.DOWN * 10
export var speed = 1.5
export var jump_speed = 100
export var max_jump = 50
export var slow_down = 1.05

var velocity = Vector3.ZERO
var double_jump_active = 0

var on_floor = false

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if !is_on_floor():
		velocity += gravity * delta
	else:
		double_jump_active = 0
	get_input(delta)
	velocity = move_and_slide(velocity, Vector3.UP)
	translation.z = 0

func get_input(delta):
	velocity.x /= slow_down
	
	if is_on_floor() and Input.is_action_pressed("up"):
		velocity.y += jump_speed
	elif double_jump_active == 1 and not is_on_floor() and Input.is_action_pressed("up"):
		double_jump_active = 2
		velocity.y += jump_speed
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
