extends Node

var biome_1 = preload("res://son/music_biome_1.wav")
var biome_2 = preload("res://son/ghost_bad_boy_2_out.wav")

var menu = preload("res://son/menu.wav")
var victoire = preload("res://son/victoire_out.wav")
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	pass 
func _process(_delta: float) -> void:
	pass

func play_music(nom):
	if audio_stream_player.playing == false:
		if nom == "biome_1":
			audio_stream_player.stream = biome_1
			audio_stream_player.play()
		if nom == "menu":
			audio_stream_player.stream = menu
			audio_stream_player.play()
		if nom == "biome_2":
			audio_stream_player.stream = biome_2
			audio_stream_player.play()
		if nom == "victoire":
			audio_stream_player.stream = victoire
			audio_stream_player.play()

func stop_music():
	audio_stream_player.stop()

func _on_audio_stream_player_finished() -> void:
	audio_stream_player.play()
