extends CanvasLayer

@onready var mort: Label = $mort
@onready var confirmation: Control = $confirmation
var menu_confirmation = false

func _ready() -> void:
	pass 



func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		menu_confirmation = false
	if menu_confirmation == false:
		confirmation.visible = false
	if menu_confirmation == true:
		confirmation.visible = true
		
	mort.text = "nombre de mort : " + str(GameManager.mort)


func _on_menu_pressed() -> void:
	MusicController.stop_music()
	get_tree().change_scene_to_file("res://scene/menu/menu.tscn")
	Engine.time_scale = 1
	GameManager.paused = false
	GameManager.menue_victoire = false

func _on_quitter_pressed() -> void:
	menu_confirmation = true


func _on_oui_pressed() -> void:
	get_tree().quit()


func _on_non_pressed() -> void:
	menu_confirmation = false
