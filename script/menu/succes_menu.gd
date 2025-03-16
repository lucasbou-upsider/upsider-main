extends Control

@onready var color_rect_1: ColorRect = $"succes/ScrollContainer/BoxContainer/succes 1/image_1/ColorRect"
@onready var color_rect_2: ColorRect = $"succes/ScrollContainer/BoxContainer/succes 2/etoile_1/ColorRect"


func _ready() -> void:
	MusicController.play_music("menu")

	if Succes.succes_fini.has(1) == true:
		color_rect_1.visible = false
	if Succes.succes_fini.has(2) == true:
		color_rect_2.visible = false

func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/menu/menu.tscn")
