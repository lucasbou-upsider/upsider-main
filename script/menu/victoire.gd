extends Control


func _ready() -> void:
	pass



func _process(_delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	MusicController.stop_music()
	get_tree().change_scene_to_file("res://scene/menu/menu.tscn")
	Engine.time_scale = 1
	GameManager.menue_victoire = false
	GameManager.paused = false
