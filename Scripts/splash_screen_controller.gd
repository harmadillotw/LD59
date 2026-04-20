extends Node2D

@onready var player_animated_sprite : AnimatedSprite2D = $Panel/Player/AnimatedSprite2D
const pre_main_menu = preload("res://Scenes/MainMenu.tscn")

var user_prefs: UserPreferences

func _ready() -> void:
	player_animated_sprite.play("moving")
	user_prefs = UserPreferences.load_or_create()
	Globals.fxVolume = user_prefs.fx_volume
	Globals.musicVolume = user_prefs.music_volume
	MasterAudioStreamPlayer.set_volume(Globals.musicVolume)
	MasterAudioStreamPlayer.play_music_game()
	RoverAudioStreamPlayer.set_volume(Globals.fxVolume)
	
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_packed(pre_main_menu)
