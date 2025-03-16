extends AnimatedSprite2D

@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@export var temps_activation = 2

func _ready() -> void:
	collision_shape_2d.disabled = true
	lance_flamme()



func _process(_delta: float) -> void:
	pass


func lance_flamme():
	play("activation")
	await get_tree().create_timer(0.2).timeout
	collision_shape_2d.disabled = false
	await get_tree().create_timer(0.7).timeout
	play("default")
	await get_tree().create_timer(temps_activation).timeout
	play("desactivation")
	await get_tree().create_timer(0.7).timeout
	collision_shape_2d.disabled = true
	await get_tree().create_timer(3).timeout
	lance_flamme()

#flamme
func _on_area_2d_area_entered(_area: Area2D) -> void:
	_area.get_parent().mort()
