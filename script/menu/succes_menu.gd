extends Control

#succes
@onready var succes_1: Label = $"succes/ScrollContainer/MarginContainer/BoxContainer/succes 1"
@onready var succes_2: Label = $"succes/ScrollContainer/MarginContainer/BoxContainer/succes 2"
@onready var succes_3: Label = $"succes/ScrollContainer/MarginContainer/BoxContainer/succes 3"
@onready var succes_4: Label = $"succes/ScrollContainer/MarginContainer/BoxContainer/succes 4"
@onready var succes_5: Label = $"succes/ScrollContainer/MarginContainer/BoxContainer/succes 5"

#image des succes
@onready var succes_image_1: TextureRect = $"succes/ScrollContainer/MarginContainer/BoxContainer/succes 1/succes_image_1"
@onready var succes_image_2: TextureRect = $"succes/ScrollContainer/MarginContainer/BoxContainer/succes 2/succes_image_2"

func _ready() -> void:
	MusicController.play_music("menu")
	traduction()
	if Succes.succes_fini.has(1) == false:
		succes_image_1.show_behind_parent = true
	if Succes.succes_fini.has(2) == false:
		succes_image_2.show_behind_parent = true

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/menu/menu.tscn")
	
func traduction():
	if GameManager.language == "FR":
		succes_1.text = "la main verte: finir le monde 1"
		succes_2.text = "verocide: tué un vero"
		succes_3.text = "finir le niv bonus"
		succes_4.text = "le début de la fin: atteindre 20 mort"
		succes_5.text = "mais c quoi c truc ?: débloquer son première upside"
	if GameManager.language == "EN":
		succes_1.text = "green thumb: end the world 1"
		succes_2.text = "verocide: killed a vero"
		succes_3.text = "finish the bonus level"
		succes_4.text = "the beginning of the end: reach 20 deaths"
		succes_5.text = "But what is this thing ?: unlocking your first upside"
