extends Camera2D

@onready var player: script_player = $"../player"

##tremblement de caméra##

@export var shake_fade: float = 5.0
@export var rando_steng = 30

var _shake_strength: float = 0.0

var look = 0

func _process(delta: float) -> void:
	
	position = player.position
	
	#regarder en haut et en bas
	if Input.is_action_pressed("haut") and player.is_on_floor() == true:
		look +=1
		print(look)
		if look >= 40:
			position = player.position + Vector2(0,-200)
	elif Input.is_action_pressed("bas") and player.is_on_floor() == true:
		look +=1
		print(look)
		if look >= 40:
			position = player.position + Vector2(0,200)
	if Input.is_action_just_released("haut") or Input.is_action_just_released("bas"):
		look = 0

	#tremblement d'ecran
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
