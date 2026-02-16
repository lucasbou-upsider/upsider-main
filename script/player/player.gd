extends CharacterBody2D
class_name script_player

var SPEED = 250.0
var JUMP_VELOCITY = -400.0

var nouv = false
var can_jump = false
var coyote_time = 0.3

var nombre_zoom_camera := Vector2(0,0)
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var nouv_player: AnimationPlayer = $ui/UI_debloquage/AnimationPlayer
@onready var animationplatforme: AnimationPlayer = $ui/platforme/Animationplatforme
@onready var son_mort: AudioStreamPlayer = $son/Mort
@onready var pose_piece: AudioStreamPlayer = $son/pose_piece
@onready var particule_mort: CPUParticles2D = $particule_mort
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player_camera: Camera2D = $"../Player_camera"
@onready var animation_maxpiece: AnimationPlayer = $ui/maxpiece/Animation_maxpiece
var crane = preload("res://scene/objets/crane.tscn")
@onready var jump_timer: Timer = $jump_timer
@onready var jump_buffering_timer: Timer = $jump_buffering_timer

var gravity = 800
var fall_gravity = 900

var was_airbound := false #si le perso retombe

func _ready() -> void:
	GameManager.gain_coin_signal.connect(gain_coin)
	GameManager.drop_coin_signal.connect(drop_coin)
	GameManager.pos_platforme_signal.connect(lose_platforme)
	
func _physics_process(delta: float) -> void:

	animate()
	debloquage()
	succes()
	capacite()
	#max_piece()
	
	
	if GameManager.player_mort == true:
		mort()
	
	if is_on_floor():
		if was_airbound:
			was_airbound = false
			animated_sprite_2d.scale = Vector2(1.3, 0.7)
	else :
		velocity.y += get_good_gravity() * delta
		was_airbound = (true)
		
	if GameManager.paused == false:
		
		#coyote time
		if is_on_floor() and can_jump == false :
			can_jump = true
		elif can_jump == true and jump_timer.is_stopped():
			jump_timer.start(coyote_time)
		

		#jump buffering 
		if Input.is_action_just_pressed("saut") and can_jump == false :
			jump_buffering_timer.start()
		if is_on_floor() and jump_buffering_timer.time_left != 0:
			velocity.y = JUMP_VELOCITY 

		#saut dosable
		if Input.is_action_just_released("saut") and velocity.y < 0:
			velocity.y = JUMP_VELOCITY / 4
		if Input.is_action_just_pressed("saut") and can_jump == true:
			animated_sprite_2d.scale = Vector2(0.7, 1.3) 
			can_jump = false
			velocity.y = JUMP_VELOCITY

		#squash and stretch animation
		animated_sprite_2d.scale.x = move_toward(animated_sprite_2d.scale.x, 1, 3 * delta)
		animated_sprite_2d.scale.y = move_toward(animated_sprite_2d.scale.y, 1, 3 * delta)




		var direction := Input.get_axis("gauche", "droite")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		velocity.x = 0
	
	move_and_slide()

func get_good_gravity():
	if velocity.y < 0:
		return gravity
	return fall_gravity


#animation
func animate():
	if GameManager.menue_victoire == false and GameManager.paused == false:
		if Input.is_action_just_pressed("gauche"):
			animated_sprite_2d.flip_h = true
			animated_sprite_2d.offset.x = -1.5
		if Input.is_action_just_pressed("droite"):
			animated_sprite_2d.flip_h = false
			animated_sprite_2d.offset.x = 0
	
	if GameManager.skin_player == 1:
		GameManager.max_platforme = 3
		GameManager.max_piece = 3
		if GameManager.paused == false and GameManager.menue_victoire == false:
			if !velocity:
				animated_sprite_2d.play("idle")
			if velocity:
				animated_sprite_2d.play("run")

	if GameManager.skin_player == 2:
		GameManager.max_platforme = 3
		GameManager.max_piece = 3
		if GameManager.paused == false and GameManager.menue_victoire == false:
			if !velocity:
				animated_sprite_2d.play("idle_nerd")
			if velocity:
				animated_sprite_2d.play("run_nerd")

	if GameManager.skin_player == 3:
		GameManager.max_platforme = 3
		GameManager.max_piece = 3
		if GameManager.paused == false and GameManager.menue_victoire == false and in_capa == false:
			if GameManager.tp_pose == 1:
				if !velocity:
					animated_sprite_2d.play("idle_sylvan")
				if velocity:
					animated_sprite_2d.play("run_sylvan")
			if GameManager.tp_pose == 0:
				if !velocity:
					animated_sprite_2d.play("idle_sylvan_bambou")
				if velocity:
					animated_sprite_2d.play("run_sylvan_bambou")
					
	if GameManager.skin_player == 4:
		animation_player.play("skin_meven")
		GameManager.max_platforme = 2
		GameManager.max_piece = 2
		if GameManager.piece_desactiver == false:
			JUMP_VELOCITY = -450.0
			SPEED = 400.0
		if GameManager.paused == false and GameManager.menue_victoire == false:
			if !velocity:
				animated_sprite_2d.play("idle_meven")
			if velocity:
				animated_sprite_2d.play("run_meven")

#piece maximum atteint
func max_piece():
	if GameManager.piece == GameManager.max_piece:
		GameManager.piece_desactiver = true
		animation_maxpiece.play("max_piece")
		SPEED = 250
	else:
		GameManager.piece_desactiver = false
		animation_maxpiece.play("RESET")
		if GameManager.skin_player != 4:
			SPEED = 350


var arret: Array = []

#arret animation nouv skin
func arret_animation():
	arret.append("marteau")
	GlobaleUpside.debloquage_marteau_animation = false

# debloquage skin ou marteau
func debloquage():
	if !arret.has("skin"):
		if GameManager.mort == 20:
			nouv_player.play("debloquage_skin")
			arret.append("skin")
	if GlobaleUpside.debloquage_marteau_animation == true:
		nouv_player.play("debloquage_marteau")

#ui platforme
func gain_platforme(number):
	#ui platforme
	for i in range(number):
		var platforme_ui = preload("res://scene/player/ui_platforme.tscn").instantiate()
		$ui/platforme/platforme_container.add_child(platforme_ui)
	GameManager.platforme += number
func lose_platforme():
	var platforme_ui = $ui/platforme/platforme_container.get_child(0)
	if platforme_ui != null:
		platforme_ui.delete()


#signale recus du gamemanager donc apparition piece
func gain_coin():
	print("pice ui")
	GameManager.piece += 1
	var camera_player = get_parent().get_node("Player_camera")
	var tween = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	tween.tween_property(camera_player, "zoom", Vector2(1.05,1.05), 0.1)
	tween.tween_property(camera_player, "zoom", Vector2(1,1), 0.1)
	gain_platforme(GameManager.max_platforme - GameManager.platforme)
	var piece_ui = preload("res://scene/player/ui_piece_sprite.tscn").instantiate()
	$ui/piece/coin_Container.add_child(piece_ui)
func drop_coin():
	GameManager.piece -= 1
	var piece_ui = $ui/piece/coin_Container.get_child(0)
	piece_ui.delete()


func camera():
	nombre_zoom_camera = player_camera.zoom



#son quand une piece est posé
func son_pose_piece():
	pose_piece.play()
	await get_tree().create_timer(1).timeout
	pose_piece.stop()

#la moooort
func mort():
#	var crane_inst = crane.instantiate()
#	add_child(crane_inst)
	GameManager.paused = true
	particule_mort.emitting = true
	position = GameManager.derniere_piece
	GameManager.mort += 1 
	gain_platforme(GameManager.max_platforme - GameManager.platforme)
	GameManager.player_mort = false
	if GameManager.mort == 20:
		GameManager.skin_debloquer.append(2)
		print("20 mort")
		#Succes.debloquage_succes(4)
		#succes()
		debloquage()
	son_mort.play()
	await get_tree().create_timer(0.3).timeout
	GameManager.paused = false
	await get_tree().create_timer(0.7).timeout
	son_mort.stop()

var capa_effectué = false
var in_capa = false

var instance_point_tp = preload("res://scene/objets/capacite_tp.tscn")
func inst_tp(pos):
	var instance_tp = instance_point_tp.instantiate()
	instance_tp.position = pos
	get_parent().add_child(instance_tp)
#capa de sylvan
func capacite():
	var camera_player = get_parent().get_node("Player_camera")
	
	
	if GameManager.skin_player == 3:
		if Input.is_action_just_pressed("capacité") and in_capa == false:
			if GameManager.can_capa == false:
				GameManager.can_capa = true
				var tween = create_tween()
				tween.tween_property(camera_player, "zoom", Vector2(1.3,1.3), 0.1)
				tween.tween_property(camera_player, "zoom", Vector2(1.2,1.2), 0.1)
				print(GameManager.can_capa)
			elif GameManager.can_capa == true:
				GameManager.can_capa = false
				var tween = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
				tween.tween_property(camera_player, "zoom", Vector2(1.3,1.3), 0.1)
				tween.tween_property(camera_player, "zoom", Vector2(1,1), 0.2)
				print(GameManager.can_capa)
		if Input.is_action_just_pressed("lumiere") and GameManager.can_capa == true and capa_effectué == false and GameManager.on_temporary_platforme == false:
			var tween = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
			tween.tween_property(camera_player, "zoom", Vector2(1.7,1.7), 0.1)
			tween.tween_property(camera_player, "zoom", Vector2(1.5,1.4), 0.1)
			in_capa = true
			animated_sprite_2d.play("capacite_sylvan")
			capa_effectué = true
			await get_tree().create_timer(2).timeout
			GameManager.can_capa = false
			var tween1 = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
			tween1.tween_property(camera_player, "zoom", Vector2(1.3,1.3), 0.1)
			tween1.tween_property(camera_player, "zoom", Vector2(1,1), 0.1)
			in_capa = false
		if Input.is_action_just_pressed("poser_piece") and GameManager.dans_area_reprendre_tp:
			var tween = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
			tween.tween_property(camera_player, "zoom", Vector2(1,1), 0.1)
			tween.tween_property(camera_player, "zoom", Vector2(1.3,1.3), 0.2)
			in_capa = true
			capa_effectué = false
			GameManager.paused = true
			animated_sprite_2d.offset.y = -1
			animated_sprite_2d.play("rattrapage_capacite_sylvan")
			animation_player.play("capacite_sylvan")
			GameManager.tp_position = 0
			GameManager.tp_pose = 0
			await get_tree().create_timer(2).timeout
			var tween1 = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
			tween1.tween_property(camera_player, "zoom", Vector2(1.3,1.3), 0.1)
			tween1.tween_property(camera_player, "zoom", Vector2(1,1), 0.2)
			GameManager.paused = false
			animated_sprite_2d.offset.y = 0
			capa_effectué = false
			in_capa = false

#animation succes
func succes():
	if Succes.nouv_succes == true:
		nouv_player.play("debloquage_succes")
		Succes.nouv_succes = false

#truc celest
func _on_jump_timer_timeout() -> void:
	can_jump = false
