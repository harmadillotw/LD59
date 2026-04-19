extends Camera2D

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_in"):
		zoom = zoom * 1.1
	if event.is_action_pressed("zoom_out"):
		zoom = zoom * 0.9
