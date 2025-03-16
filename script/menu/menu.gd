extends Control


@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

@onready var mort: Label = $compteur_de_mort/mort
@export var mode_admin = false
@onready var menu_1: Control = $menu_1
@onready var monde_2: Control = $"menu_1/monde 2"
@onready var levier_actif: Label = $compteur_de_mort/levier_actif
@onready var speedrun_button: CheckButton = $mode_speedrun/speedrun_button
@onready var temps_speedrun_monde_1: Label = $"menu_1/monde 1/temps_speedrun_monde_1"

#niv
@onready var niv_2: Button = $"menu_1/monde 1/BoxContainer/niv 2"
@onready var niv_3: Button = $"menu_1/monde 1/BoxContainer/niv 3"
@onready var niv_4: Button = $"menu_1/monde 1/BoxContainer/niv 4"
@onready var niv_5: Button = $"menu_1/monde 1/BoxContainer/niv 5"
@onready var niv_bonus_1: Button = $"menu_1/monde 1/BoxContainer2/niv_bonus_1"
@onready var niv_6: Button = $"menu_1/monde 1/BoxContainer/niv6"
@onready var niv_7: Button = $"menu_1/monde 1/BoxContainer/niv7"
@onready var niv_8: Button = $"menu_1/monde 2/BoxContainer/niv8"
@onready var niv_9: Button = $"menu_1/monde 2/BoxContainer/niv9"


#etoile
@onready var etoile_1: AnimatedSprite2D = $"menu_1/monde 1/BoxContainer/niv1/étoile_1"
@onready var etoile_2: AnimatedSprite2D = $"menu_1/monde 1/BoxContainer/niv 2/étoile_2"
@onready var etoile_3: AnimatedSprite2D = $"menu_1/monde 1/BoxContainer/niv 3/étoile_3"
@onready var etoile_4: AnimatedSprite2D = $"menu_1/monde 1/BoxContainer/niv 4/étoile_4"
@onready var etoile_5: AnimatedSprite2D = $"menu_1/monde 1/BoxContainer/niv 5/étoile_5"
@onready var etoile_bonus_1: AnimatedSprite2D = $"menu_1/monde 1/BoxContainer2/niv_bonus_1/étoile_bonus_1"
@onready var etoile_6: AnimatedSprite2D = $"menu_1/monde 1/BoxContainer/niv6/étoile_6"
@onready var etoile_7: AnimatedSprite2D = $"menu_1/monde 1/BoxContainer/niv7/étoile_7"
@onready var etoile_8: AnimatedSprite2D = $"menu_1/monde 2/BoxContainer/niv8/étoile_8"
@onready var etoile_9: AnimatedSprite2D = $"menu_1/monde 2/BoxContainer/niv9/étoile_9"

@onready var tuto: Control = $tuto


func _ready() -> void:
	MusicController.play_music("menu")#lance la musique
	if GameManager.mort == 0:
		mort.visible = false
	#mode admin
	if mode_admin == true:
		var mode_admine_niv_debloque: Array = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 1.1]
		GameManager.niv_fini.append_array(mode_admine_niv_debloque)

	#etoile de fin de niv
	if GameManager.niv_fini.has(1.0) == true:
		etoile_1.visible = true
		etoile_1.play("recus")
		speedrun_button.disabled = true
	else:
		niv_2.visible = false
		tuto.visible = true
		

	if GameManager.niv_fini.has(2.0) == true:
		etoile_2.visible = true
		etoile_2.play("recus")
	else:
		niv_3.visible = false

	if GameManager.niv_fini.has(3.0) == true:
		etoile_3.visible = true
		etoile_3.play("recus")
	else:
		niv_4.visible = false
			
	if GameManager.niv_fini.has(4.0) == true:
		etoile_4.visible = true
		etoile_4.play("recus")
	else:
		niv_5.visible = false
			
	if GameManager.niv_fini.has(5.0) == true:
		etoile_5.visible = true
		etoile_5.play("recus")
	else:
		niv_6.visible = false

	if GameManager.niv_fini.has(6.0) == true:
		etoile_6.visible = true
		etoile_6.play("recus")
	else :
		niv_7.visible = false
	
	if GameManager.niv_fini.has(7.0) == true:
		etoile_7.visible = true
		etoile_7.play("recus")
		if GameManager.mode_speedrun == true:
			temps_speedrun_monde_1.text = str(GameManager.temps_monde_1)
			if int(GameManager.temps_monde_1) <= 7.5:
				GameManager.skin_debloquer.append(4)
		else:
			temps_speedrun_monde_1.visible = false
	else :
		monde_2.visible = false
		temps_speedrun_monde_1.visible = false
			
	if GameManager.niv_fini.has(8.0) == true:
		etoile_8.visible = true
		etoile_8.play("recus")
	else :
		niv_9.visible = false
		
	if GameManager.niv_fini.has(9.0) == true:
		etoile_9.visible = true
		etoile_9.play("recus")
	

	if GameManager.niv_fini.has(1.1) == true:
		etoile_bonus_1.visible = true
		etoile_bonus_1.play("recus")
	


	if GameManager.niv_bonus_1_debloque == true or mode_admin == true:
		niv_bonus_1.visible = true



	#texte compteur de mort
	mort.text = "nombre de mort : " + str(GameManager.mort)

	#text levier 
	if GlobaleUpside.levier_casse == false:
		levier_actif.visible = true
		levier_actif.text = "nombre de levier actif : " + str(GlobaleUpside.levier_actif)



func _process(_delta: float) -> void:
	pass


#bouton niv
func _on_niv_1_pressed() -> void:
	bouton()
	get_tree().change_scene_to_file("res://scene/niveau/monde_1/niv_1.tscn")
func _on_niv_2_pressed() -> void:
	bouton()
	get_tree().change_scene_to_file("res://scene/niveau/monde_1/niv_2.tscn")
func _on_niv_3_pressed() -> void:
	bouton()
	get_tree().change_scene_to_file("res://scene/niveau/monde_1/niv_3.tscn")
func _on_niv_4_pressed() -> void:
	bouton()
	get_tree().change_scene_to_file("res://scene/niveau/monde_1/niv_4.tscn")
func _on_niv_5_pressed() -> void:
	bouton()
	get_tree().change_scene_to_file("res://scene/niveau/monde_1/niv_5.tscn")
func _on_niv_6_pressed() -> void:
	bouton()
	get_tree().change_scene_to_file("res://scene/niveau/monde_1/niv_6.tscn")
func _on_niv_7_pressed() -> void:
	bouton()
	get_tree().change_scene_to_file("res://scene/niveau/monde_1/niv_7.tscn")
func _on_niv_8_pressed() -> void:
	bouton()
	get_tree().change_scene_to_file("res://scene/niveau/monde_2/niv_8.tscn")
func _on_niv_9_pressed() -> void:
	bouton()
	get_tree().change_scene_to_file("res://scene/niveau/monde_2/niv_9.tscn")

func _on_niv_bonus_1_pressed() -> void:
	bouton()
	get_tree().change_scene_to_file("res://scene/niveau/monde_1/niv_bonus_1.tscn")
func _on_quit_button_down() -> void:
	get_tree().quit()
func _on_quit_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/menu/menu_2.tscn")
func _on_button_succes_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/menu/succes_menu.tscn")

func bouton():
	audio_stream_player.play()
	MusicController.stop_music()


func _on_check_button_toggled(_toggled_on: bool) -> void:
	if GameManager.mode_speedrun == false:
		GameManager.mode_speedrun = true
	elif GameManager.mode_speedrun == true:
		GameManager.mode_speedrun = false
	print(GameManager.mode_speedrun)
