extends TextureRect



func _ready() -> void:
	modulate.a = 0.0
	pivot_offset.y = size.y
	
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUINT)
	
	tween.tween_property(self , "modulate:a", 1.0, 0.3)
	tween.parallel().tween_property(self, "scale:y", 1.0, 0.5).from(4)

func delete():
	var tween = create_tween()
	tween.tween_property(self , "modulate:a", 0, 0.3)
	tween.parallel().tween_property(self, "scale:y", 1, 0.5).from(4)
	queue_free()
