extends Control

@onready var label: Label = $CanvasLayer/Label

@onready var label_2: Label = $CanvasLayer/Label2
@onready var label_3: Label = $CanvasLayer/Label3

#label 1
func _on_area_2_dlabel_area_entered(area: Area2D) -> void:
	if area.get_parent() is script_player:
		label.visible = true
func _on_area_2_dlabel_area_exited(area: Area2D) -> void:
	if area.get_parent() is script_player:
		label.visible = false

#label 2
func _on_area_2_dlabel_2_area_entered(area: Area2D) -> void:
	if area.get_parent() is script_player:
		label_2.visible = true
func _on_area_2_dlabel_2_area_exited(area: Area2D) -> void:
	if area.get_parent() is script_player:
		label_2.visible = false

#label 3

func _on_area_2_dlabel_3_area_entered(area: Area2D) -> void:
	if area.get_parent() is script_player:
		label_3.visible = true
func _on_area_2_dlabel_3_area_exited(area: Area2D) -> void:
	if area.get_parent() is script_player:
		label_3.visible = false

func mort():
	pass
