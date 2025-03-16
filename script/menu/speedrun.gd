extends CanvasLayer

var time = GameManager.timer_speedrun

func _process(delta: float) -> void:
	if GameManager.mode_speedrun == true:
		time = float(time) + delta / 60
	
		update_ui()

	
func update_ui():
	
	var formated_time = str(time)
	var decimale_index = formated_time.find(".")
	
	if decimale_index > 0:
		formated_time = formated_time.left(decimale_index + 3)
		
	GameManager.timer_speedrun = formated_time
	
	$Label.text = formated_time
