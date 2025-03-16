extends Node2D

func _ready() -> void:
	GameManager.tp_position = position
	print(GameManager.tp_position)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("lumiere") and GameManager.tp_pose == 1 and GameManager.mode_capacite == true:
		GameManager.tp_position = 0
		queue_free()
	if GameManager.tp_pose == 0:
		queue_free()


func _on_area_2d_area_entered(_area: Area2D) -> void:
	GameManager.dans_area_reprendre_tp = true


func _on_area_2d_area_exited(_area: Area2D) -> void:
	GameManager.dans_area_reprendre_tp = false
