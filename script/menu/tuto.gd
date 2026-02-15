extends Control

@onready var label: Label = $CanvasLayer/Label

@onready var label_2: Label = $CanvasLayer/Label2
@onready var label_3: Label = $CanvasLayer/Label3


#label 1
func _on_area_2_dlabel_area_entered(area: Area2D) -> void:
	if area.get_parent() is script_player:
		var tween = create_tween()
		tween.tween_property(label, "modulate:a", 1.0, 1)
func _on_area_2_dlabel_area_exited(area: Area2D) -> void:
	if area.get_parent() is script_player:
		var tween = create_tween()
		tween.tween_property(label, "modulate:a", 0, 1)

#label 2
func _on_area_2_dlabel_2_area_entered(area: Area2D) -> void:
	if area.get_parent() is script_player:
		var tween = create_tween()
		tween.tween_property(label_2, "modulate:a", 1.0, 1)
func _on_area_2_dlabel_2_area_exited(area: Area2D) -> void:
	if area.get_parent() is script_player:
		var tween = create_tween() 
		tween.tween_property(label_2, "modulate:a", 0, 1)

#label 3
func _on_area_2_dlabel_3_area_entered(area: Area2D) -> void:
	if area.get_parent() is script_player:
		var tween = create_tween()
		tween.tween_property(label_3, "modulate:a", 1.0, 1)
func _on_area_2_dlabel_3_area_exited(area: Area2D) -> void:
	if area.get_parent() is script_player:
		var tween = create_tween()
		tween.tween_property(label_3, "modulate:a", 0, 1)

func mort():
	pass
