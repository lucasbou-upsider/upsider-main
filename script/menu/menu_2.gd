extends Control

@onready var language: Button = $menu_1/option/language

@onready var jouer: Button = $menu_1/button/jouer
@onready var quit: Button = $menu_1/button/quit

func _ready() -> void:
	MusicController.play_music("menu")

func _process(_delta: float) -> void:
	language.text = GameManager.language
	langue()
	
	
func langue():
	if GameManager.language == "EN":
		jouer.text = "Play"
		quit.text = "Exit"
	if GameManager.language == "FR":
		jouer.text = "Jouer"
		quit.text = "Quitter"


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
	if GameManager.language == "EN":
		GameManager.language = "FR"
	elif GameManager.language == "FR":
		GameManager.language = "EN"
