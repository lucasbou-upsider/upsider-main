extends Control

@onready var language: Button = $menu_1/option/language
var input_language = 0

func _ready() -> void:
	MusicController.play_music("menu")



func _process(_delta: float) -> void:
	if input_language == GameManager.language.size():
		input_language = 0
	language.text = GameManager.language.get(input_language)
	


func _on_jouer_pressed() -> void:
	$AudioStreamPlayer.play()
	get_tree().change_scene_to_file("res://scene/menu/menu.tscn")


func _on_quit_pressed() -> void:
	$AudioStreamPlayer.play()
	get_tree().quit()


func _on_credits_pressed() -> void:
	$AudioStreamPlayer.play()
	get_tree().change_scene_to_file("res://scene/menu/credits.tscn")


func _on_language_pressed() -> void:
	input_language += 1
