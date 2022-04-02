extends Area

var speed = 0.5
var start = false

func shoot(start_pos):
	translation = start_pos
	start = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if start:
		translation.z += speed

func _on_Bullet_body_entered(body):
	if body.name == "FollowPlayer":
		body.death()
