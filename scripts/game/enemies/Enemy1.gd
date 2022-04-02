extends Spatial

signal shoot(start_position)

func _ready():
	$ShootTimer.start(Global.rng.randf_range(0.5, 1.2))

func _on_ShootTimer_timeout():
	emit_signal("shoot", translation)
