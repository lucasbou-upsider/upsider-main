extends TextureRect


func _ready() -> void:
	var twenn = create_tween()
	twenn.tween_property(self, "scale", Vector2(1.3,1.3), 0.1)
	twenn.tween_property(self, "scale", Vector2(1,1), 0.1)


func delete():
	queue_free()
