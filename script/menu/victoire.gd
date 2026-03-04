extends Control

func _on_button_pressed() -> void:
	Engine.time_scale = 1
	$loadingscreen/AnimationLoadingScreen.play("fade_out")


func _on_animation_loading_screen_animation_finished(_anim_name: StringName) -> void:
	MusicController.stop_music()
	GameManager.next_loading_sceen = "res://scene/menu/menu.tscn"
	get_tree().change_scene_to_file("res://scene/loading.tscn")
	GameManager.menue_victoire = false
	GameManager.paused = false
