extends Node2D
class_name script_niv

#platforme lumiere 
var isntance_platforme_lumiere = preload("res://scene/objets/platforme_lumière.tscn")
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
	if GameManager.skin_player != 4:
		GameManager.platforme = GameManager.max_platforme
	else:
		GameManager.platforme = 2
	GameManager.piece = 0
	GameManager.piece_depose = 0
	GameManager.derniere_piece = spawn.position
	GameManager.tp_pose = 0
	GameManager.mode_capacite = false


func _process(_delta: float) -> void:
	
	#pause
	if Input.is_action_just_pressed("pause") and GameManager.menue_victoire == false:
		pausemenu()
	
	#déclenchement victoire
	if GameManager.piece_depose == piece_requis and victoire == false:
		_victoire()
		
	
	#poser platforme
	if GameManager.mode_capacite == false:
		if GameManager.platforme >= 1:
			if Input.is_action_just_pressed("lumiere") and GameManager.paused == false:
				inst_platforme(get_global_mouse_position())
				GameManager.platforme -= 1
	#se tp au point de tp
	var gros_zoom = false
	if GameManager.mode_capacite == true:
		if Input.is_action_just_pressed("lumiere") and GameManager.paused == false and GameManager.tp_pose == 0:
			gros_zoom = true
			GameManager.paused = true
			await get_tree().create_timer(2).timeout
			GameManager.tp_pose = 1
			inst_tp(player.position)
			GameManager.paused = false
			gros_zoom = false
			GameManager.mode_capacite = false
		if Input.is_action_just_pressed("lumiere") and GameManager.paused == false and GameManager.tp_pose == 1:
			if tp_utilise == false:
				tp_utilise = true
				player.position = GameManager.tp_position
			if tp_utilise == true:
				pass
	
	#capacité
	if GameManager.skin_player == 3:
		if Input.is_action_just_pressed("capacité") and gros_zoom == false:
			if GameManager.mode_capacite == true:
				GameManager.mode_capacite = false
			elif GameManager.mode_capacite == false:
				GameManager.mode_capacite = true
			print(GameManager.mode_capacite)
	
	#déposé les piece dans la boite
	if possible_piece_depose == true:
		if Input.is_action_just_pressed("poser_piece"):
			if GameManager.piece >= 1:
				particule_caisse.emitting = true
				GameManager.piece -= 1
				GameManager.piece_depose +=1
				player.son_pose_piece()

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
	add_child(instance_tp)

#victoire
func _victoire():
	MusicController.stop_music()
	GameManager.paused = true
	GameManager.menue_victoire = true
	menue_victoire.show()
	Engine.time_scale = 0
	if GameManager.niv_fini.has(niv):
		pass
	else:
		GameManager.niv_fini.append(niv)
	victoire = true
	#timer fin monde 1
	if niv == 7:
		GameManager.temps_monde_1 = GameManager.timer_speedrun


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
