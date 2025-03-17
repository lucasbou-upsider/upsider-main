extends Control

@onready var label: Label = $Label
@onready var label_2: Label = $Label2
@onready var label_3: Label = $Label3

func _process(delta: float) -> void:
	if GameManager.language == "EN":
		label.text = "Left-click to place a platform
						(you only have 3 platforms!)"
		label_3.text = "Put all the pieces in the box!"
		label_2.text = "the coins give you back your 3 platforms!"
	else:
		label.text = "Clic gauche pour placer une platforme
						   ( tu n'as que 3 plateformes ! )"
		label_3.text = "Mets toutes les pieces dans la boite !"
		label_2.text = "les pieces te redonnent tes 3 plateformes ! "
