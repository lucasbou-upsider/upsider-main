extends Node2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $attrapage/CollisionShape2D
@export var nombre_de_spawn := 0

func _ready() -> void:
	animated_sprite_2d.offset = Vector2(0.0,0.9)
	if nombre_de_spawn != GameManager.quete_sylvan:
		queue_free()
	

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is script_player :
		animated_sprite_2d.offset = Vector2(0.0,0.0)
		animated_sprite_2d.play("fuite")
		await get_tree().create_timer(0.5).timeout
		collision_shape_2d.disabled = true
		await get_tree().create_timer(0.5).timeout
		queue_free()
		GameManager.quete_sylvan += 1
		
		
func mort():#fonction ajouter pour anlever les bugs avec les ennemies
	pass


func _on_attrapage_area_entered(area: Area2D) -> void:
	if area.get_parent() is script_player:
		print("attraper !")
