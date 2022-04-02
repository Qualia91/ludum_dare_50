extends Label

signal complete(string_id)
signal tick(string_id)

# 0: uses time_step
# 1: uses max_time
export(int) var type = 0
export(float) var time_step = 1
export(float) var max_time = 1

var value = 1
var current_val = 0
var string_id
var step

func start(start_val, end_value, step, string_id):
	self.current_val = start_val
	self.value = end_value
	self.string_id = string_id
	self.step = step
	self.text = str(current_val)
	match type:
		0:
			$Timer.start(time_step)
		1:
			time_step = max_time / float(value)
			$Timer.start(time_step)

func _on_Timer_timeout():
	if current_val != value:
		emit_signal("tick", string_id)
		current_val += step
		text = str(current_val)
	else:
		$Timer.stop()
		emit_signal("complete", string_id)

func stop():
	$Timer.stop()
	self.text = ""
