extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@export var nbr_levier = 0

var is_in_area = false
var no_repete = false

func _ready() -> void:
	#deja activé
	if nbr_levier == 1:
		if GlobaleUpside.levier_1 == true:
			animated_sprite_2d.play("deja_activé")
			no_repete = true
	if nbr_levier == 2:
		if GlobaleUpside.levier_2 == true:
			animated_sprite_2d.play("deja_activé")
			no_repete = true
	if nbr_levier == 3:
		if GlobaleUpside.levier_3 == true:
			animated_sprite_2d.play("deja_activé")
			no_repete = true
	if nbr_levier == 4:
		if GlobaleUpside.levier_4 == true:
			animated_sprite_2d.play("deja_activé")
			no_repete = true



func _process(_delta: float) -> void:
	if is_in_area == true:
		if Input.is_action_just_pressed("poser_piece") and GlobaleUpside.levier_casse == false and no_repete == false:
			activation()
		
	if GlobaleUpside.levier_casse == true:
		animated_sprite_2d.play("casse")
		cpu_particles_2d.lifetime = 0.2
		cpu_particles_2d.speed_scale = 0.5

func activation():
	GameManager.camera_shake = true
	animated_sprite_2d.play("activation")
	GlobaleUpside.activation(nbr_levier)
	GlobaleUpside.levier_actif += 1
	animation_player.play("activation")
	no_repete = true

func _on_area_2d_area_entered(_area: Area2D) -> void:
	is_in_area = true

func _on_area_2d_area_exited(_area: Area2D) -> void:
	is_in_area = false
