extends Node

#levier upside eau
var levier_casse = true
#nombre levier
var levier_1 = false
var levier_2 = false
var levier_3 = false
var levier_4 = false

var levier_actif = 0

var marteau = false
var debloquage_marteau_animation = false

var upside_debloque: Array = []

func _ready() -> void:
	pass

func activation(nbr):
	if nbr == 1:
		levier_1 = true
	if nbr == 2:
		levier_2 = true
	if nbr == 3:
		levier_3 = true
	if nbr == 4:
		levier_4 = true


func _process(_delta: float) -> void:
	if marteau == true:
		levier_casse = false
