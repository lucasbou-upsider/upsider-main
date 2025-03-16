extends CanvasLayer

signal on_transition_finished

@onready var color_rect: ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	color_rect.visible = false
#	animation_player.animation_finished.connect(on_animation_finished)
	
#func on_animation_finished(anime_name):
#	if anime_name == "fate_to_black":
#		on_transition_finished.emit()
#		animation_player.play("fade_to_normal")
#	elif anime_name == "fade_to_normal":
#		color_rect.visible = true
	

func transition():
	color_rect.visible = true
	animation_player.play("fade_to_black")
	await get_tree().create_timer(1).timeout
	on_transition_finished.emit()
	animation_player.play("fade_to_normal")
