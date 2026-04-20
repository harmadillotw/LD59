extends AudioStreamPlayer

const game_music = preload("res://Audio/drive2.wav")

func _play_sound(music: AudioStream, volume = 0.0):
	if stream == music:
		return

	stream = music
	volume_db = volume
	
	play()
	
	
func play_rover_engine():
	_play_sound(game_music,Globals.musicVolume)
	#track = 1
func stop_rover_engine():
	stop()
func set_volume(newVol: float):
	volume_db = newVol	
	
