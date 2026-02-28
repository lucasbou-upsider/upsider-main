extends Node2D
class_name script_niv

#platforme lumiere 
var isntance_platforme_lumiere = preload("res://scene/player/platforme_lumière.tscn")
var instance_point_tp = preload("res://scene/objets/capacite_tp.tscn")

@onready var particule_caisse: CPUParticles2D = $player/particule_caisse
@onready var menue_victoire: Control = $player/victoire
@onready var pause_menu: CanvasLayer = $player/pause_menu
@export var niv = 0.0
@export var piece_requis = 0
@onready var spawn: Marker2D = $spawn
@onready var spawn_player: CharacterBody2D = $player
@onready var score: Label = $score/score
var possible_piece_depose = false
@onready var score_position = $score/depose_piece
@onready var player: script_player = $player
var victoire = false
var tp_utilise = false

#reset
func _ready() -> void:
	music()
	GameManager.platforme = 0
	if GameManager.skin_player != 4:
		player.gain_platforme(3)
		GameManager.max_platforme = 3
	else:
		player.gain_platforme(2)
		GameManager.max_platforme = 2
	GameManager.piece = 0
	GameManager.piece_depose = 0
	GameManager.derniere_piece = spawn.position
	GameManager.tp_pose = 0
	GameManager.can_capa = false
	GameManager.piece_bonus_depose = 0
	GameManager.active_bonus_challenge = false


func _process(_delta: float) -> void:
	
	#pause
	if Input.is_action_just_pressed("pause") and GameManager.menue_victoire == false:
		pausemenu()
	
	#déclenchement victoire
	if GameManager.piece_depose == piece_requis and victoire == false:
		_victoire()
		
	
	#poser platforme
	if GameManager.platforme >= 1:
		if Input.is_action_just_pressed("lumiere") and GameManager.paused == false and GameManager.can_capa == false:
			print(GameManager.can_capa)
			$Player_camera.shake_fade = 10
			$Player_camera.rando_steng = 5
			$Player_camera._shake_strength = 5
			$Player_camera.shake()
			inst_platforme(get_global_mouse_position())
			GameManager.pos_platforme()
	
	#déposé les piece dans la boite
	if possible_piece_depose == true:
		if Input.is_action_just_pressed("poser_piece"):
			if GameManager.piece >= 1 and GameManager.can_capa == false:
				GameManager.drop_coin()
				var camera_player = get_node("Player_camera")
				var tween = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
				tween.tween_property(camera_player, "zoom", Vector2(1.1,1.1), 0.2)
				tween.tween_property(camera_player, "zoom", Vector2(1,1), 0.2)
				particule_caisse.emitting = true
				GameManager.piece_depose +=1
				player.was_airbound = true

	#affichage score
	score.text = str(GameManager.piece_depose) + "/" + str(piece_requis)

#musisue de fond
func music():
	if niv <= 7:
		MusicController.play_music("biome_1")
	if niv >=  8:
		MusicController.play_music("biome_2")



#platforme lumiére
func inst_platforme(pos):
	var instance = isntance_platforme_lumiere.instantiate()
	instance.position = pos
	add_child(instance)

func inst_tp(pos):
	var instance_tp = instance_point_tp.instantiate()
	instance_tp.position = pos
	get_parent().add_child(instance_tp)

#victoire
func _victoire():
	MusicController.stop_music()
	GameManager.paused = true
	GameManager.menue_victoire = true
	GameManager.platforme = 0
	menue_victoire.show()
	Engine.time_scale = 0
	if GameManager.active_bonus_challenge == true:
		GameManager.niv_fini.append(niv + 0.2)
		if GameManager.niv_fini.count(niv +0.2) == 2:
			GameManager.niv_fini.erase(niv + 0.2)
	else:
		GameManager.niv_fini.append(niv)
		if GameManager.niv_fini.count(niv) == 2:
			GameManager.niv_fini.erase(niv)
	
	if GameManager.niv_unlock.has(niv + 1) == false:
		GameManager.niv_unlock.append(niv + 1)
	victoire = true
	#timer fin monde 1
	if niv == 7 and GameManager.timer_speedrun == 0:
		GameManager.temps_monde_1 = GameManager.timer_speedrun
		if int(GameManager.temps_monde_1) <= 300: #300 secondes = 10min
			GameManager.skin_debloquer.append(4)
			GameManager.unlock("skin")
	GameManager.save_game()

#menue de pause
func pausemenu():
	if GameManager.paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0

	GameManager.paused = !GameManager.paused

#l'imite du monde
func _on_area_2d_area_entered(_area: Area2D) -> void:
	_area.get_parent().mort()

#dans l'area de la boite déposée
func _on_depose_piece_area_entered(_area: Area2D) -> void:
	possible_piece_depose = true
func _on_depose_piece_area_exited(_area: Area2D) -> void:
	possible_piece_depose = false

func mort():
	pass
