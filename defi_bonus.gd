extends Node2D

@export var effect: String
var active_bonus_effect = false
var node_player 
var node_niveau
var node_camera
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var label_nom_effect: RichTextLabel = $CanvasLayer/ColorRect/Label_nom_effect
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	canvas_layer.visible = false
	node_player = get_parent().get_parent().get_node("player")
	node_camera = get_parent().get_parent().get_node("Player_camera")
	node_niveau = get_parent()


func _process(_delta: float) -> void:
	if GameManager.piece != 0:
		queue_free()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is script_player:
		var zoom_camera_player = node_camera.zoom
		label_nom_effect.text = "[wave]" + effect
		GameManager.active_bonus_challenge = true
		collision_shape_2d.set_deferred("disabled", true)
		sprite_2d.visible = false
		if effect == "-1 platforme":
			GameManager.max_platforme -= 1
			for i in range(GameManager.platforme):
				GameManager.pos_platforme()
			node_player.gain_platforme(GameManager.max_platforme)
			
		var tween = create_tween()
		tween.tween_property(node_camera, "zoom", zoom_camera_player + Vector2(0.2,0.2), 0.2)
		canvas_layer.visible = true
		await get_tree().create_timer(3, true, false, true).timeout
		var tween1 = create_tween()
		tween1.tween_property(node_camera, "zoom", zoom_camera_player, 0.1)
		canvas_layer.visible = false
		tween1.tween_callback(queue_free)


		#queue_free()
		
