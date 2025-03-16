extends StaticBody2D



func _ready() -> void:
	#capacité
	if GameManager.skin_player == 2:
		await get_tree().create_timer(2.5).timeout
		queue_free()
	else:
		await get_tree().create_timer(1.5).timeout
		queue_free()



func _process(_delta: float) -> void:
	pass
