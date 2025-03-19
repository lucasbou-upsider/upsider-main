extends CanvasLayer

@onready var mort: Label = $mort
@onready var confirmation: Control = $confirmation
var menu_confirmation = false
@onready var label_confirmation: Label = $confirmation/Label_confirmation
@onready var oui: Button = $confirmation/BoxContainer/oui
@onready var non: Button = $confirmation/BoxContainer/non
@onready var quitter: Button = $BoxContainer2/quitter
@onready var menu: Button = $BoxContainer/menu

var text_nombre_de_mort = "nombre de mort : "

func _ready() -> void:
	traduction()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		menu_confirmation = false
	if menu_confirmation == false:
		confirmation.visible = false
	if menu_confirmation == true:
		confirmation.visible = true
		
	mort.text = text_nombre_de_mort + str(GameManager.mort)

func traduction():
	if GameManager.language == "EN":
		text_nombre_de_mort = "number of deaths : "
		label_confirmation.text = "Are you sure you want to leave ?"
		oui.text = "Yes"
		non.text = "No"
		quitter.text = "Quit"
		menu.text = "back to menu"

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
