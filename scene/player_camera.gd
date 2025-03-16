extends Camera2D

##tremblement de caméra##

@export var shake_fade: float = 5.0
@export var rando_steng = 30

var _shake_strength: float = 0.0

func _process(delta: float) -> void:
	if _shake_strength > 0:
		_shake_strength = lerpf(_shake_strength, 0, shake_fade * delta)
		offset = rando_offset()
	if GameManager.camera_shake == true:
		shake()

func shake():
	_shake_strength = rando_steng
	GameManager.camera_shake = false
	
func rando_offset():
	return Vector2(
		randf_range(-_shake_strength, _shake_strength),
		randf_range(-_shake_strength, _shake_strength)
	)
