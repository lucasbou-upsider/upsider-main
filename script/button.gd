extends BoxContainer

@export var intensity: float = 0.1
@export var duration: float = 0.2

func _process(_delta: float) -> void:
	# Get all the children of this vboxcontainer (which are all button)
	for button: Button in get_children():
		button.pivot_offset = button.size / 2
		if button.is_hovered():
			button.scale = button.scale.lerp(scale + Vector2.ONE * intensity, duration)
		else:
			button.scale = button.scale.lerp(Vector2.ONE, duration)

func start_tween(object: Object, property: NodePath, final_val: Variant, duration: float) -> void:
	var tween = create_tween()
	tween.tween_property(object, property, final_val, duration)
	await tween.finished
	tween.kill()
