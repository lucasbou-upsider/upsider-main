extends StaticBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


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
	tween.tween_property(animated_sprite_2d, "scale", Vector2(1.1,0.8), 0.05)
	tween.tween_property(animated_sprite_2d, "scale", Vector2(1,1), 0.05)

func _process(_delta: float) -> void:
	pass
