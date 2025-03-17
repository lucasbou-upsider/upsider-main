extends AnimatedSprite2D

@onready var description_skin: Label = $"../description_skin"
@onready var etoile_skin: AnimatedSprite2D = $"../étoile_skin"
@onready var menu_2: Control = $"../.."
@onready var box_container: BoxContainer = $"../BoxContainer"


var marche = true
var dernier_player_debloquer 
var limite_player_debloquer 

func _ready() -> void:
	if GameManager.nouv_skin == true:
		etoile_skin.visible = true
		
func _process(_delta: float) -> void:
	actualisation()
	
	if marche == false:
		if GameManager.language == "FR":
			if GameManager.skin_player == 1:
				play("player_base")
				description_skin.text = "le skin de base de tous les joueurs"
			if GameManager.skin_player == 2:
				description_skin.text = "skin assiste permettant que les plateformes durent plus longtemps"
				play("player_nerd")
			if GameManager.skin_player == 3:
				description_skin.text = "skin ayant le pouvoir de se teleporter"
				play("player_sylvan")
			if GameManager.skin_player == 4:
				description_skin.text = "skin allant beaucoup trop vite"
				play("player_meven")
		if GameManager.language == "EN":
			if GameManager.skin_player == 1:
				play("player_base")
				description_skin.text = "the base skin of all players"
			if GameManager.skin_player == 2:
				description_skin.text = "skin assists allowing platforms to last longer"
				play("player_nerd")
			if GameManager.skin_player == 3:
				description_skin.text = "skin with the power to teleport"
				play("player_sylvan")
			if GameManager.skin_player == 4:
				description_skin.text = "skin going too fast"
				play("player_meven")

	#afficher l'etoile
	if GameManager.skin_player == 2:
		etoile_skin.visible = false

	#animation
	if marche == true:
		if GameManager.skin_player == 4:
			position.x += 3
		else:
			position.x += 2
		if GameManager.skin_player == 1:
			play("marche_base")
		if GameManager.skin_player == 2:
			play("marche_nerd")
		if GameManager.skin_player == 3:
			play("marche_sylvan")
		if GameManager.skin_player == 4:
			play("marche_meven") 

func actualisation():
	if GameManager.skin_debloquer.size() == 1:
		box_container.visible = false
		description_skin.visible = false


	GameManager.skin_debloquer.sort()#trie le tableau des player
	limite_player_debloquer = GameManager.skin_debloquer.back() + 1
	dernier_player_debloquer = GameManager.skin_debloquer.back()



##changement de skin##

var numplayer = 0
func _on_button_2_pressed() -> void:
	numplayer += 1
	if numplayer == GameManager.skin_debloquer.size():
		numplayer = 0
	print("le numplayer est " + str(numplayer))
	GameManager.skin_player = GameManager.skin_debloquer.get(numplayer)
	print("le skin du joueur est le numero " + str(GameManager.skin_player))
func _on_button_pressed() -> void:
	var nombredeplayer 
	numplayer -= 1
	nombredeplayer = GameManager.skin_debloquer.size()
	nombredeplayer -= 1
	if numplayer == -1:
		numplayer = nombredeplayer
	print("le numplayer est " + str(numplayer))
	GameManager.skin_player = GameManager.skin_debloquer.get(numplayer)
	print("le skin du joueur est le numero " + str(GameManager.skin_player))

func _on_arret_annimation_area_entered(_area: Area2D) -> void:
	marche = false
