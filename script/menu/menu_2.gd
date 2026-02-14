extends Control

@onready var language: Button = $menu_1/option/language

@onready var jouer: Button = $menu_1/button/jouer
@onready var quit: Button = $menu_1/button/quit
@onready var delete_file: Button = $"menu_1/option/delete file"

func _ready() -> void:
	MusicController.play_music("menu")

func _process(_delta: float) -> void:
	language.text = GameManager.language
	langue()
	
	
func langue():
	if GameManager.language == "EN":
		jouer.text = "Play"
		quit.text = "Exit"
		delete_file.text = "delete file"
	if GameManager.language == "FR":
		jouer.text = "Jouer"
		quit.text = "Quitter"
		delete_file.text = "supprimer sauvegarde"

func _on_jouer_pressed() -> void:
	$AudioStreamPlayer.play()
	get_tree().change_scene_to_file("res://scene/menu/menu.tscn")


func _on_quit_pressed() -> void:
	$AudioStreamPlayer.play()
	GameManager.quit_game()


func _on_credits_pressed() -> void:
	$AudioStreamPlayer.play()
	get_tree().change_scene_to_file("res://scene/menu/credits.tscn")


func _on_language_pressed() -> void:
	if GameManager.language == "EN":
		GameManager.language = "FR"
	elif GameManager.language == "FR":
		GameManager.language = "EN"

#supprimer le fichier de sauvegarde
func _on_delete_file_pressed() -> void:
	var dir := DirAccess.open("user://")
	if dir == null:
		push_error("Impossible d'ouvrir le dossier")
		return

	if dir.file_exists("user://SaveFile.json"):
		var err = dir.remove("user://SaveFile.json")
		##!!!!!remettre les var à zero!!!!!##
		GameManager.skin_debloquer = [1]
		GameManager.niv_fini = []
		GameManager.mort = 0
		GlobaleUpside.upside_debloque = []
		print(err)
		if err != OK:
			push_error("Erreur lors de la suppression : %s" % err)
	else:
		print("Le fichier n'existe pas :", "user://SaveFile.json")
