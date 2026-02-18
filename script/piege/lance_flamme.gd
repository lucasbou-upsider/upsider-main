extends AnimatedSprite2D

@export var temps_activation = 2
@export var retourne = false
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var cpu_particles_2d: CPUParticles2D = $particle1/CPUParticles2D
@onready var cpu_particles_2d_4: CPUParticles2D = $particle1/CPUParticles2D4
@onready var cpu_particles_2d_3: CPUParticles2D = $particle2/CPUParticles2D3
@onready var cpu_particles_2d_2: CPUParticles2D = $particle2/CPUParticles2D2
@onready var cpu_particles_2d_5: CPUParticles2D = $particle2/CPUParticles2D4
@onready var cpu_particles_2d_6: CPUParticles2D = $particle2/CPUParticles2D5

func _ready() -> void:
	print(rotation)
	if retourne == true:
		print("rotat")
		cpu_particles_2d.gravity = Vector2(0.0,200.0)
		cpu_particles_2d_4.gravity = Vector2(0.0,200.0)
		cpu_particles_2d_3.gravity = Vector2(0.0,200.0)
		cpu_particles_2d_2.gravity = Vector2(0.0,200.0)
		cpu_particles_2d_5.gravity = Vector2(0.0,200.0)
		cpu_particles_2d_6.gravity = Vector2(0.0,200.0)
	lance_flamme()



func _process(_delta: float) -> void:
	pass


func lance_flamme():
	animation_player.play("activation")
	await get_tree().create_timer(10).timeout
	animation_player.play("desactivation")
	await get_tree().create_timer(10).timeout
	lance_flamme()

#flamme
func _on_area_2d_area_entered(_area: Area2D) -> void:
	_area.get_parent().mort()

func mort():
	pass
