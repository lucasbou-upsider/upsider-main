extends Node2D

var piece_déposé = 0
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
var piece_collecte = false
@export var forme = 0 ## forme: 0 = normal, 1 = ralentissement 
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var son: AudioStreamPlayer2D = $son
signal piece_recupere


func _ready() -> void:
	if forme == 1: 
		sprite_2d.modulate = Color(0.718, 0.18, 0.0)


func _process(_delta: float) -> void:
	if piece_collecte == true:
		collision_shape_2d.disabled = true
		sprite_2d.visible = false
		point_light_2d.visible = false
	if GameManager.piece_desactiver == true:
		piece_desactiver()
	else:
		sprite_2d.play("default")
		collision_shape_2d.disabled = false

func piece_desactiver():
	sprite_2d.play("piece_desactiver")
	collision_shape_2d.disabled = true



func _on_area_2d_area_entered(_area: Area2D) -> void:
	if _area.get_parent() is script_player:
		queue_free()
		piece_recupere.emit()
		cpu_particles_2d.emitting = true
		piece_collecte = true
		GameManager.derniere_piece = position
		GameManager.gain_coin(forme)
		#son.play()
		#await get_tree().create_timer(1).timeout
		#son.stop()

#signal mort
func _on_niv_1_mort() -> void:
	pass

func mort():
	pass
