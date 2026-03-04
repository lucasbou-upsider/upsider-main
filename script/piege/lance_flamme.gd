extends StaticBody2D

@export var temps_activation = 2
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_polygon_2: CollisionPolygon2D = $CollisionPolygon2
@onready var collision_polygon_1: CollisionPolygon2D = $CollisionPolygon1
@onready var collision_shape_area_death: CollisionShape2D = $Area2D/CollisionShapeAreaDeath

func _ready() -> void:
	collision_polygon_1.set_deferred("disabled",false)
	collision_polygon_2.set_deferred("disabled",true)







func mort():
	pass


func _on_activation_timeout() -> void:
	animated_sprite_2d.play("activation")
	collision_polygon_1.set_deferred("disabled",true)
	collision_polygon_2.set_deferred("disabled",false)
func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "activation":
		collision_shape_area_death.set_deferred("disabled",false)
		animated_sprite_2d.play("encours")
		await get_tree().create_timer(temps_activation).timeout
		collision_shape_area_death.set_deferred("disabled",true)
		animated_sprite_2d.play("desactivation")
		await get_tree().create_timer(1).timeout
		collision_polygon_1.set_deferred("disabled",false)
		collision_polygon_2.set_deferred("disabled",true)
		$activation.start()
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is script_player:
		area.get_parent().mort()
