extends Node2D
@onready var point_light_2d: PointLight2D = $PointLight2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var cpu_particles_2d_2: CPUParticles2D = $CPUParticles2D2
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var area_explosion: Area2D = $Area_explosion
var arret = false
@onready var lance_lumi_re: Node2D = $"."
@onready var cpu_particles_explosion: CPUParticles2D = $CPUParticles_explosion

var is_in_explosion = false

func _ready() -> void:
	cpu_particles_2d.emitting = true

func _process(_delta: float) -> void:
	animated_sprite_2d.play("default")
	if GameManager.paused == false:
		position.y += 1


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is script_player:
		area.get_parent().mort()
		cpu_particles_2d_2.emitting = true
		queue_free()


func _on_area_2d_body_entered(_body: Node2D) -> void:
	collision_shape_2d.set_deferred("disabled", "true")
	cpu_particles_explosion.emitting = true
	animated_sprite_2d.visible = false
	point_light_2d.enabled = false
	arret = true
	if is_in_explosion == true:
		GameManager.player_mort = true
	await get_tree().create_timer(0.2).timeout
	queue_free()


func _on_area_explosion_area_entered(area: Area2D) -> void:
	if area.get_parent() is script_player:
		is_in_explosion = true


func _on_area_explosion_area_exited(area: Area2D) -> void:
	if area.get_parent() is script_player:
		is_in_explosion = false


func mort():
	queue_free()
