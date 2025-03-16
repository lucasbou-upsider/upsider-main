extends Node2D

@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var point_light_2d: PointLight2D = $PointLight2D

func _on_area_2d_area_entered(area: Area2D) -> void:
	GlobaleUpside.marteau = true
	GlobaleUpside.debloquage_marteau_animation = true
	sprite_2d.visible = false
	point_light_2d.enabled = false
	cpu_particles_2d.emitting = true
	GameManager.skin_debloquer.append(3)
	await get_tree().create_timer(1).timeout
	queue_free()
