extends CharacterBody2D
class_name script_player

var SPEED = 300.0
var JUMP_VELOCITY = -400.0

var nouv = false
var can_jump = false
var coyote_time = 0.3
var zoom = false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var nouv_player: AnimationPlayer = $UI_debloquage/AnimationPlayer
@onready var animationplatforme: AnimationPlayer = $platforme/Animationplatforme
@onready var son_mort: AudioStreamPlayer = $son/Mort
@onready var pose_piece: AudioStreamPlayer = $son/pose_piece
@onready var particule_mort: CPUParticles2D = $particule_mort
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var crane = preload("res://scene/objets/crane.tscn")


func _physics_process(delta: float) -> void:

	animate()
	debloquage()
	indicateur_platforme()
	succes()
	capacite()
	
	if GameManager.player_mort == true:
		mort()
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if is_on_floor() and can_jump == false:
		can_jump = true
	elif can_jump == true and $jump_timer.is_stopped():
		$jump_timer.start(coyote_time)
		
	if GameManager.paused == false:
		if Input.is_action_just_released("saut") and velocity.y < 0:
			velocity.y = JUMP_VELOCITY / 4

		if Input.is_action_just_pressed("saut") and can_jump == true:
			can_jump = false
			velocity.y = JUMP_VELOCITY

		var direction := Input.get_axis("gauche", "droite")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		move_and_slide()



#animation
func animate():
	if GameManager.menue_victoire == false and GameManager.paused == false:
		if Input.is_action_just_pressed("gauche"):
			animated_sprite_2d.flip_h = true
		if Input.is_action_just_pressed("droite"):
			animated_sprite_2d.flip_h = false
	
	if GameManager.skin_player == 1:
		if GameManager.paused == false and GameManager.menue_victoire == false:
			if !velocity:
				animated_sprite_2d.play("idle")
			if velocity:
				animated_sprite_2d.play("run")

	if GameManager.skin_player == 2:
		if GameManager.paused == false and GameManager.menue_victoire == false:
			if !velocity:
				animated_sprite_2d.play("idle_nerd")
			if velocity:
				animated_sprite_2d.play("run_nerd")

	if GameManager.skin_player == 3:
		if GameManager.paused == false and GameManager.menue_victoire == false:
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
		JUMP_VELOCITY = -450.0
		SPEED = 400.0
		if GameManager.paused == false and GameManager.menue_victoire == false:
			if !velocity:
				animated_sprite_2d.play("idle_meven")
			if velocity:
				animated_sprite_2d.play("run_meven")

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
func indicateur_platforme():
	animationplatforme.play(str(GameManager.platforme))

#son quand une piece est posé
func son_pose_piece():
	pose_piece.play()
	await get_tree().create_timer(1).timeout
	pose_piece.stop()

#la moooort
func mort():
#	var crane_inst = crane.instantiate()
#	add_child(crane_inst)
	particule_mort.emitting = true
	position = GameManager.derniere_piece
	GameManager.platforme = GameManager.max_platforme
	GameManager.mort += 1 
	GameManager.player_mort = false
	if GameManager.mort == 20:
		GameManager.skin_debloquer.append(2)
		print("20 mort")
		#Succes.debloquage_succes(4)
		#succes()
		debloquage()
	son_mort.play()
	await get_tree().create_timer(1).timeout
	son_mort.stop()

var zoom_effectué = false
var gros_zoom = false

func capacite():
	if GameManager.skin_player == 3:
		if Input.is_action_just_pressed("capacité") and gros_zoom == false:
			if zoom == false:
				animation_player.play("zoom_camera")
				zoom = true
			elif zoom == true:
				animation_player.play("dezoom_camera")
				zoom = false
		if Input.is_action_just_pressed("lumiere") and zoom == true and zoom_effectué == false:
			gros_zoom = true
			animated_sprite_2d.play("capacite_sylvan")
			animation_player.play("capacite_sylvan")
			zoom_effectué = true
			zoom = false
			await get_tree().create_timer(2).timeout
			gros_zoom = false
		if Input.is_action_just_pressed("poser_piece") and GameManager.dans_area_reprendre_tp:
			gros_zoom = true
			zoom_effectué = false
			GameManager.paused = true
			animated_sprite_2d.offset.y = -1
			animated_sprite_2d.play("rattrapage_capacite_sylvan")
			animation_player.play("capacite_sylvan")
			GameManager.tp_position = 0
			GameManager.tp_pose = 0
			await get_tree().create_timer(2).timeout
			GameManager.paused = false
			animated_sprite_2d.offset.y = 0
			gros_zoom = false

#animation succes
func succes():
	if Succes.nouv_succes == true:
		nouv_player.play("debloquage_succes")
		Succes.nouv_succes = false

#truc celest
func _on_jump_timer_timeout() -> void:
	can_jump = false
