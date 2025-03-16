extends Node2D

var depose_piece_bonus_possible = false
@export var pieces_requis_bonus = 0
@onready var particule_caisse: CPUParticles2D = $player/particule_caisse
@onready var score_bonus: Label = $score_bonus
@onready var menue_victoire: Control = $player/victoire
@onready var player: script_player = $"../player"

func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	#déposer des pieces
	if depose_piece_bonus_possible == true:
		if Input.is_action_just_pressed("poser_piece"):
			if GameManager.piece >= 1:
				player.son_pose_piece()
				GameManager.piece_bonus_depose += 1 
				GameManager.piece -= 1 

	#affichage score
	score_bonus.text = str(GameManager.piece_bonus_depose) + "/" + str(pieces_requis_bonus)
	
	#victoire
	if GameManager.piece_bonus_depose == pieces_requis_bonus:
		victoire_bonus()

func victoire_bonus():
	MusicController.stop_music()
	GameManager.debloque(1.1)
	get_tree().change_scene_to_file("res://scene/menu/menu.tscn")
	GameManager.piece_bonus_depose = 0

func _on_depose_piece_bonus_area_entered(_area: Area2D) -> void:
	depose_piece_bonus_possible = true
func _on_depose_piece_bonus_area_exited(_area: Area2D) -> void:
	depose_piece_bonus_possible = false
