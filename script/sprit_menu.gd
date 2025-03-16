extends AnimatedSprite2D



func _ready() -> void:
	if GameManager.skin_player == 1:
		play("idle")
	if GameManager.skin_player == 2:
		play("idle_nerd")



func _process(delta: float) -> void:
	pass
