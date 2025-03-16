extends StaticBody2D

@onready var niv_1: Node2D = $"../.."


func _ready() -> void:
	pass 


func _process(_delta: float) -> void:
	pass


func _on_area_2d_area_entered(_area: Area2D) -> void:
	_area.get_parent().mort()
