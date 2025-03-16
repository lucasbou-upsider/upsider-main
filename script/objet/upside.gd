extends Node2D

@onready var upside: AnimatedSprite2D = $upisde
@export var type_upside = ""
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

func _ready() -> void:
	if type_upside == "feu":
		upside.play("feu")
	if type_upside == "eau" and GlobaleUpside.levier_actif == 4:
		print("c bon")
		upside.play("eau")
	else:
		upside.play("default")
		collision_shape_2d.disabled = true
	if type_upside == "menu":
		upside.play("default")
		if GlobaleUpside.upside_debloque.has("eau"):
			upside.play("eau")



func _on_area_2d_area_entered(_area: Area2D) -> void:
	GlobaleUpside.upside_debloque.append(type_upside)
	queue_free()
	#créé une cinématique 
