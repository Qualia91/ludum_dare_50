extends Spatial

var rot = 0

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	$RotNode.rotation_degrees = Vector3(0, 0, rot)
	rot += 1
