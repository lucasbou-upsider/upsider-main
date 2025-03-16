extends Node

#1 = finir monde 1; 2 = tué un vero; 3 = débloquer le niv bonus; 4 = atteindre 20 morts; 5 = débloquer le première Upside 
var succes_fini: Array = []

var nouv_succes = false

func _ready() -> void:
	pass 


func _process(_delta: float) -> void:
	pass

func debloquage_succes(nombre_succes):
	succes_fini.append(nombre_succes)
	print(succes_fini)
