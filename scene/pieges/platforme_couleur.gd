extends StaticBody2D

var player 
var piece_ui 
var piece_couleur
var has_piece
@export var couleur: String
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
var ui_piece_forme_1 = preload("res://scene/player/ui_piece_forme_1_sprite.tscn").instantiate()


func _ready() -> void:
	player = get_parent().get_parent().get_node("player") 
	piece_ui = player.get_node("ui").get_node("piece").get_node("coin_Container")
	print(player)
	print(piece_ui)
	if couleur == "red":
		sprite_2d.modulate = Color(11.335, 0.0, 0.0, 0.306)

func _process(_delta: float) -> void:
	var nbr_piece = piece_ui.get_child_count()
	var piece 
	if couleur == "red":
		if nbr_piece != 0:
			for i in range(nbr_piece ):
				piece = piece_ui.get_child(i)
				if piece.name == "ui_piece_forme_1_sprite":
					sprite_2d.modulate = Color(11.335, 0.0, 0.0, 1.0)
					collision_shape_2d.set_deferred("disabled", false)
		else :
			sprite_2d.modulate = Color(11.335, 0.0, 0.0, 0.306)
			collision_shape_2d.set_deferred("disabled", true)
