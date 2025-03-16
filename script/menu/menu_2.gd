extends Control


func _ready() -> void:
	MusicController.play_music("menu")



func _process(_delta: float) -> void:
	pass


func _on_jouer_pressed() -> void:
	$AudioStreamPlayer.play()
	get_tree().change_scene_to_file("res://scene/menu/menu.tscn")


func _on_quit_pressed() -> void:
	$AudioStreamPlayer.play()
	get_tree().quit()


func _on_credits_pressed() -> void:
	$AudioStreamPlayer.play()
	get_tree().change_scene_to_file("res://scene/menu/credits.tscn")
