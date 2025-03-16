extends Node2D

var piece_déposé = 0
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
var piece_collecte = false
@export var id = 0
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var son: AudioStreamPlayer2D = $son


func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	if piece_collecte == true:
		collision_shape_2d.disabled = true
		sprite_2d.visible = false
		point_light_2d.visible = false

	
func _on_area_2d_area_entered(_area: Area2D) -> void:
	cpu_particles_2d.emitting = true
	GameManager.platforme = GameManager.max_platforme
	GameManager.piece += 1
	piece_collecte = true
	GameManager.derniere_piece = position
	son.play()
	await get_tree().create_timer(1).timeout
	son.stop()

#signal mort
func _on_niv_1_mort() -> void:
	pass
