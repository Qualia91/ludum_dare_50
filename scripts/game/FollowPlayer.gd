extends StaticBody

signal death

var path

func _ready():
	pass
	
func give_path(path):
	self.path = path

func _physics_process(delta):
	if not Input.is_action_pressed("slow") and path:
		var next_pos = path.pop_front()
		translation = next_pos

func death():
	emit_signal("death")
