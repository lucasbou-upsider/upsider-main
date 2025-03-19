extends Control

@onready var label: Label = $Label

func _ready() -> void:
	if GameManager.language == "EN":
		label.text = "This regen allows you to regain all your platforms"
	else:
		label.text = "Ce regen te permet de regagner toutes tes plateformes"
