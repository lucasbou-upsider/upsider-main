extends Node

const save_location = "user://SaveFile3.json"

var content_to_save: Dictionary = {
	"skin_unlock": [1],
	"niv_unlock": [1.0],
	"niv_finis": [],
	"number_of_death": 0,
	"speedrun_time_world1": 0,
	"upside": [],
	"skin": 1,
	"avance_skin_unlock": 0,
}

func _ready() -> void:
	_load()

#enregister les var
func _save():
	var file = FileAccess.open(save_location, FileAccess.WRITE)
	file.store_var(content_to_save.duplicate())
	file.close()

#charger les variables 
func _load():
	if FileAccess.file_exists(save_location):
		var file = FileAccess.open(save_location, FileAccess.READ)
		var data = file.get_var()
		file.close()
		
		var save_data = data.duplicate()
		#!! remettre cette ligne à jour pour chaque nouvelle var ajouté !!
		#penser a les reinitialisé dans le bouton delete dans le menu2
		content_to_save.skin_unlock = save_data.skin_unlock
		content_to_save.niv_unlock = save_data.niv_unlock
		content_to_save.number_of_death = save_data.number_of_death
		content_to_save.speedrun_time_world1 = save_data.speedrun_time_world1
		content_to_save.upside = save_data.upside
		content_to_save.niv_finis = save_data.niv_finis
		content_to_save.skin = save_data.skin
		content_to_save.avance_skin_unlock = save_data.avance_skin_unlock
