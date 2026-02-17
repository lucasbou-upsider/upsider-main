extends Control


@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

@onready var mort = $compteur_de_mort/mort
@export var mode_admin = false
@onready var menu_1: Control = $menu_1
@onready var monde_2: Control = $"menu_1/monde 2"
@onready var levier_actif:  = $compteur_de_mort/levier_actif
@onready var speedrun_button: CheckButton = $mode_speedrun/speedrun_button
@onready var temps_speedrun_monde_1:  = $"menu_1/monde 1/temps_speedrun_monde_1"
@onready var quit: Button = $menu_1/option/BoxContainer2/quit
@onready var titre_monde_1:  = $"menu_1/monde 1/titre"
@onready var titre_monde_2:  = $"menu_1/monde 2/Label2"
@onready var label_speedrun:  = $mode_speedrun/Label_speedrun

#niv
@onready var niv_1: Button = $"menu_1/monde 1/BoxContainer/niv1"
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

var text_nombre_de_mort = "nombre de mort : "
var text_nombre_de_levier = "nombre de levier actif : "

func _ready() -> void:
	
	#speedrun timer
	if GameManager.timer_visible == true:
		speedrun_button.set_pressed_no_signal(true)
	
	MusicController.play_music("menu")#lance la musique
	if GameManager.mort == 0:
		mort.visible = false
	##mode admin
	#if mode_admin == true:
		#var mode_admine_niv_debloque: Array = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 1.1]
		#GameManager.niv_fini.append_array(mode_admine_niv_debloque)

	#etoile de fin de niv
	if GameManager.niv_fini.has(1.0) == true:
		etoile_1.visible = true
		etoile_1.play("recus")
		$mode_speedrun.visible = false
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
		GameManager.unlock("succes")
		Succes.debloquage_succes(1)
		GameManager.temps_monde_1 = GameManager.timer_speedrun
		temps_speedrun_monde_1.text = str(GameManager.temps_monde_1)
		if int(GameManager.temps_monde_1) <= 300: #300 secondes = 10min
			temps_speedrun_monde_1.visible = true
			GameManager.skin_debloquer.append(4)
			GameManager.unlock("skin")
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
	


	if GameManager.niv_bonus_1_debloque == true :
		niv_bonus_1.visible = true

	#traduction text comteur de levier et de mort 
	if GameManager.language == "EN":
		text_nombre_de_levier = "[wave]number of active levers : "
		text_nombre_de_mort = "[wave]number of deaths : "

	#texte compteur de mort
	mort.text = text_nombre_de_mort + str(GameManager.mort)

	#text levier 
	if GlobaleUpside.levier_casse == false:
		levier_actif.visible = true
		levier_actif.text = text_nombre_de_levier + str(GlobaleUpside.levier_actif)



func _process(_delta: float) -> void:
	#if Input.is_action_just_pressed("droite"):
		#print('mode admin')
		#mode_admin = true
	#print(mode_admin)
	traduction()

func traduction():
	#niveau
	var nom_niveau = "lvl"
	if GameManager.language == "EN":
		nom_niveau = "lvl "
	else:
		nom_niveau = "niv "
	niv_1.text = nom_niveau + "1"
	niv_2.text = nom_niveau + "2" 
	niv_3.text = nom_niveau + "3" 
	niv_4.text = nom_niveau + "4" 
	niv_5.text = nom_niveau + "5" 
	niv_6.text = nom_niveau + "6" 
	niv_7.text = nom_niveau + "7" 
	niv_8.text = nom_niveau + "8" 
	niv_9.text = nom_niveau + "9"
	#option
	
	if GameManager.language == "EN":
		quit.text = "Exit"
		niv_bonus_1.text = "bonus level"
		niv_bonus_1.set_deferred("theme_override_font_sizes/font_size", 15)
		titre_monde_1.text = "[wave]-world 1"
		titre_monde_2.text = "[wave]-world 2"
		label_speedrun.text = "[wave]speedrun mode"

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
	GameManager.save_game()
	get_tree().quit()
func _on_quit_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/menu/menu_2.tscn")
func _on_button_succes_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/menu/succes_menu.tscn")

func bouton():
	audio_stream_player.play()
	MusicController.stop_music()


func _on_check_button_toggled(_toggled_on: bool) -> void:
	if GameManager.timer_visible == false:
		GameManager.timer_visible = true
	elif GameManager.timer_visible == true:
		GameManager.timer_visible = false
	print(GameManager.timer_visible)

@onready var roadmap_liste:  = $Roadmap/Roadmap_liste
func _on_roadmap_button_pressed() -> void:
	if roadmap_liste.visible == false:
		roadmap_liste.visible = true
	else:
		roadmap_liste.visible = false
