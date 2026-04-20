extends Node2D
@onready var fx_slider : HSlider =$Panel/VBoxContainer/FXHSlider2
@onready var music_slider : HSlider =$Panel/VBoxContainer/MusicHSlider
var user_prefs: UserPreferences
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fx_slider.value = Globals.fxVolume
	music_slider.value = 	Globals.musicVolume

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_music_h_slider_value_changed(value: float) -> void:
	Globals.musicVolume = value
	
	MasterAudioStreamPlayer.set_volume(value)
	if user_prefs:
		user_prefs.music_volume = value
		user_prefs.save()


func _on_fxh_slider_2_value_changed(value: float) -> void:
	Globals.fxVolume = value
	
	if user_prefs:
		user_prefs.fx_volume = value
		user_prefs.save()


func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
