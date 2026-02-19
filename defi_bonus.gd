extends Node2D

@export var effect: String
var active_bonus_effect = false
var node_player 
var node_niveau
var node_camera
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var label_nom_effect: RichTextLabel = $CanvasLayer/ColorRect/Label_nom_effect

func _ready() -> void:
	canvas_layer.visible = false
	node_player = get_parent().get_node("player")
	node_camera = get_parent().get_node("Player_camera")
	node_niveau = get_parent()


func _process(_delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is script_player:
		var zoom_camera_player = node_camera.zoom
		label_nom_effect.text = "[wave]" + effect
		var tween = create_tween()
		tween.tween_property(node_camera, "zoom", zoom_camera_player + Vector2(0.2,0.2), 0.2)
		canvas_layer.visible = true
		await get_tree().create_timer(3).timeout
		var tween1 = create_tween()
		tween1.tween_property(node_camera, "zoom", zoom_camera_player, 0.1)
		canvas_layer.visible = false
		active_bonus_effect = true
		if effect == "-1 platforme":
			GameManager.max_platforme -= 1
			for i in range(GameManager.platforme):
				GameManager.pos_platforme()
			node_player.gain_platforme(GameManager.max_platforme)
		#queue_free()
		
