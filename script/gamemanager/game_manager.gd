extends Node
#language
var language = "EN"

#nombre de platforme restant
var platforme = 3
var max_platforme = 3
#nombre de piece
var piece = 0
var max_piece = 3
var piece_desactiver = false
#nombre de piece déposé dans la boite
var piece_depose = 0
var piece_bonus_depose = 0
#compteur de mort
var mort := 0
var mort_vero = 0
#pause
var paused = false
#respawn
var derniere_piece = 0
#victoire
var menue_victoire = false
#capacité
var can_capa = false


#1 = player de base 2 = player nerd 3 = sylvan tp 4 = meven
var skin_player = 1

#player débloqué
var skin_debloquer: Array = [1, 3, 4]
var quete_sylvan := 0

#capacité tp position
var tp_position = 0
var tp_pose = false
var dans_area_reprendre_tp = false

#mode speedrun
var timer_visible = false
var timer_speedrun = 0
var temps_monde_1 = 0

#niv fini
var niv_fini: Array
var niv_unlock: Array = [1.0]

var player_mort = false

#etoil nouv skin debloqué
var nouv_skin = false
var nouv_skin_animation = false

#tremblement d'écran
var camera_shake = false

#niv bonus débloqué
var niv_bonus_1_debloque = false

#tuto
var tuto_fini = false

#savoir si le perso est sur une platforme lumiere ou cassable
var on_temporary_platforme = false

#signal quand on debloque un perso ou un objet
signal unlock_signal
func unlock(things_unlock):
	unlock_signal.emit(things_unlock)

#coin signal 
signal gain_coin_signal
func gain_coin():
	gain_coin_signal.emit()
signal drop_coin_signal
func drop_coin():
	drop_coin_signal.emit()

#signal poser des platformes
signal pos_platforme_signal
func pos_platforme():
	platforme -= 1
	pos_platforme_signal.emit()



func _ready() -> void:
	SaveLoad._load()
	skin_debloquer = SaveLoad.content_to_save.skin_unlock
	niv_unlock = SaveLoad.content_to_save.niv_unlock
	mort = SaveLoad.content_to_save.number_of_death
	temps_monde_1 = SaveLoad.content_to_save.speedrun_time_world1
	GlobaleUpside.upside_debloque = SaveLoad.content_to_save.upside
	niv_fini = SaveLoad.content_to_save.niv_finis

func debloque(debloque_niv):
	if debloque_niv == 1.1:
		niv_bonus_1_debloque = true
		
func save_game():
	SaveLoad.content_to_save.skin_unlock = skin_debloquer
	SaveLoad.content_to_save.niv_unlock = niv_unlock
	SaveLoad.content_to_save.number_of_death = mort
	SaveLoad.content_to_save.speedrun_time_world1 = temps_monde_1
	SaveLoad.content_to_save.upside = GlobaleUpside.upside_debloque
	SaveLoad.content_to_save.niv_finis = niv_fini
	SaveLoad._save()
	print("game saved")
