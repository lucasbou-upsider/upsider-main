extends CharacterBody2D

var SPEED = -50
var facing_right = false

func _ready() -> void:
	pass 


func _process(delta: float) -> void:

	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if !$RayCast2D.is_colliding() && is_on_floor():
		flip()

	velocity.x = SPEED
	move_and_slide()

# tourner
func flip():
	facing_right = !facing_right
	
	scale.x = abs(scale.x) * -1
	if facing_right:
		SPEED = abs(SPEED)
	else:
		SPEED = abs(SPEED) * -1


func _on_area_2d_area_entered(_area: Area2D) -> void:
	if _area.get_parent() is script_player:
		_area.get_parent().mort()
	
func mort():
	print("mort")
	GameManager.mort_vero += 1
	if GameManager.mort_vero == 1:
		Succes.debloquage_succes(2)
		Succes.nouv_succes = true
	queue_free()
