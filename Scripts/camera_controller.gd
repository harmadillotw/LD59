extends Camera2D

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_in"):
		zoom = zoom * 1.1
		if zoom.x > 1.0:
			zoom = Vector2(1.0,1.0)
	if event.is_action_pressed("zoom_out"):
		zoom = zoom * 0.9
		if zoom.x < 0.35:
			zoom = Vector2(0.35,0.35)
