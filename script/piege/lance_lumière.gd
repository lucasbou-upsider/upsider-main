extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var projectile_lumiere = preload("res://scene/pieges/projectile_lumiere.tscn")
var projectile_flamme = preload("res://scene/pieges/projectile_flamme.tscn")
@export var temps = 2.0
@export var alternatif = false

func _ready() -> void:
	if alternatif == false:
		tire_lumiere(animated_sprite_2d.position)
	if alternatif == true:
		tire_flamme(animated_sprite_2d.position)
	
func _process(_delta: float) -> void:
	pass
	
func tire_flamme(pos):
	animated_sprite_2d.play("activation")
	await get_tree().create_timer(temps).timeout
	animated_sprite_2d.play("default")
	var instance = projectile_flamme.instantiate()
	instance.position = pos
	add_child(instance)
	await get_tree().create_timer(temps).timeout
	tire_flamme(animated_sprite_2d.position)

func tire_lumiere(pos):
	animated_sprite_2d.play("activation")
	await get_tree().create_timer(temps).timeout
	animated_sprite_2d.play("default")
	var instance = projectile_lumiere.instantiate()
	instance.position = pos
	add_child(instance)
	await get_tree().create_timer(temps).timeout
	tire_lumiere(animated_sprite_2d.position)
