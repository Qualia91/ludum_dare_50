extends Spatial

signal shoot(start_position)

var rng

func _ready():
	self.rng = RandomNumberGenerator.new()
	rng.randomize()
	$ShootTimer.start(rng.randf_range(0.5, 1.5))

func _on_ShootTimer_timeout():
	emit_signal("shoot", translation)
