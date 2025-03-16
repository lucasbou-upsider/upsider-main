extends StaticBody2D

@onready var regen_inverse: AudioStreamPlayer = $"Regen_inversé"
@onready var regen: AudioStreamPlayer = $Regen
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
var player_detecter = false

func _ready() -> void:
	pass 

func _process(_delta: float) -> void:
	if player_detecter == true:
		cpu_particles_2d.speed_scale = 3
	if player_detecter == false:
		cpu_particles_2d.speed_scale = 1

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is script_player:
		player_detecter = true
		if GameManager.platforme <= 2:
			regen.play()
		else :
			regen_inverse.play()
		GameManager.platforme = GameManager.max_platforme



func _on_area_2d_area_exited(_area: Area2D) -> void:
	player_detecter = false
