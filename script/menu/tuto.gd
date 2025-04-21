extends Control

@onready var label: Label = $Label
@onready var label_2: Label = $Label2
@onready var label_3: Label = $Label3
@onready var label_tuto: Label = $tuto/Label
@onready var player: script_player = $"../player"
@onready var spawn: Marker2D = $"../spawn"


func _process(_delta: float) -> void:
	if player.position != spawn.position:
		pass
	
	if GameManager.language == "EN":
		label.text = "Left-click to place a platform
						(you only have 3 platforms!)"
		label_3.text = "Put all the pieces in the box!"
		label_2.text = "the coins give you back your 3 platforms!"
		label_tuto.text = "the number of remaining platforms is displayed at the bottom right"
	else:
		label.text = "Clic gauche pour placer une platforme
						   ( tu n'as que 3 plateformes ! )"
		label_3.text = "Mets toutes les pieces dans la boite !"
		label_2.text = "les pieces te redonnent tes 3 plateformes ! "
