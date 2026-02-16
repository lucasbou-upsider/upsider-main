extends StaticBody2D
class_name platforme_lumiere
@onready var animated_sprite_2d: AnimatedSprite2D = $Platforme_animatedsprite


func _ready() -> void:
	#capacité
	if GameManager.skin_player == 2:
		animation_juice()
		await get_tree().create_timer(2.5).timeout
		queue_free()
	else:
		animation_juice()
		await get_tree().create_timer(1.5).timeout
		queue_free()


func animation_juice():
	var tween = create_tween()
	tween.tween_property(animated_sprite_2d, "scale", Vector2(1.2,0.7), 0.05)
	tween.tween_property(animated_sprite_2d, "scale", Vector2(1,1), 0.05)

func _process(_delta: float) -> void:
	pass

#savoir si le joueur est sur la platforme
func _on_platforme_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is script_player:
		GameManager.on_temporary_platforme = true
func _on_platforme_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() is script_player:
		GameManager.on_temporary_platforme = false
