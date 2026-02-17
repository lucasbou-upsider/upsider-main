extends Node2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $attrapage/CollisionShape2D
@export var nombre_de_spawn := 0
var est_partie = false
@onready var label_indice_niv: RichTextLabel = $Label_indiceNiv
@export var indice_niv: String
@onready var detection_collision_shape_2d: CollisionShape2D = $detection/CollisionShape2D
#lvl6 puis lvl2 puis lvl4


func _ready() -> void:
	label_indice_niv.visible = false
	label_indice_niv.text = str("[wave]") + str(indice_niv)
	animated_sprite_2d.offset = Vector2(0,1)
	if nombre_de_spawn != GameManager.quete_sylvan:
		queue_free()
	

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is script_player :
		if GameManager.quete_sylvan != 2:
			if animated_sprite_2d.flip_h == true:
				animated_sprite_2d.offset = Vector2(-1,0)
			else :
				animated_sprite_2d.offset = Vector2(1,0)
			animated_sprite_2d.play("fuite")
			await get_tree().create_timer(0.5).timeout
			est_partie = true
			GameManager.quete_sylvan += 1
			detection_collision_shape_2d.set_deferred("disabled", true)
			
		
		
func mort():#fonction ajouter pour enlever les bugs avec les ennemies
	pass


func _on_attrapage_area_entered(area: Area2D) -> void:
	if area.get_parent() is script_player:
		if est_partie == false:
			GameManager.unlock("skin")
			GameManager.skin_debloquer.append(3)
			queue_free()
		else:
			label_indice_niv.visible = true


func _on_attrapage_area_exited(area: Area2D) -> void:
	if area.get_parent() is script_player:
		label_indice_niv.visible = false


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite_2d.animation == "fuite":
		animated_sprite_2d.offset = Vector2(1,1.5)
		animated_sprite_2d.play("papier")
