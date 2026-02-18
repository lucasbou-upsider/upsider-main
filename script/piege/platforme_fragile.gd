extends StaticBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
var shake_intensity = 0.3
var shake_duration = 3
var shake_time = 0
var original_pos = Vector2.ZERO
@onready var timer: Timer = $Timer

var nbr_mort_player 

func _ready() -> void:
	original_pos = sprite_2d.position 
	nbr_mort_player = GameManager.mort
	$CollisionShape2D.set_deferred("disabled", false)
	$Area2D/CollisionShape2D.set_deferred("disabled", false)
	$Sprite2D.visible = true

func _process(delta: float) -> void:
	#platforme qui shake de + en +
	if shake_time < 2:
		shake_intensity = 0.6
	else :
		shake_intensity = 0.3
	#detection que le joueur est mort
	if GameManager.mort != nbr_mort_player:
		$CollisionShape2D.set_deferred("disabled", false)
		$Area2D/CollisionShape2D.set_deferred("disabled", false)
		$Sprite2D.visible = true
		nbr_mort_player = GameManager.mort
	
	
	#shake de la platforme
	if shake_time > 0:
		shake_time -= delta
		sprite_2d.position = original_pos + Vector2(
			randf_range(-shake_intensity, shake_intensity),
			randf_range(-shake_intensity, shake_intensity)
		)
	if shake_time <= 0:
		sprite_2d.position  = original_pos


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is script_player:
		GameManager.on_temporary_platforme = true
		shake_time = shake_duration
		timer.start()


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() is script_player:
		GameManager.on_temporary_platforme = false


func _on_timer_timeout() -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	$Sprite2D.visible = false
