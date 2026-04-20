extends Camera2D

var _previousPosition: Vector2 = Vector2(0, 0);
var _moveCamera: bool = false;
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_in"):
		zoom = zoom * 1.1
		if zoom.x > 1.0:
			zoom = Vector2(1.0,1.0)
	if event.is_action_pressed("zoom_out"):
		zoom = zoom * 0.9
	var level : Level = Globals.command_levels[Globals.current_level]
	if zoom.x < level.max_zoom:
		zoom = Vector2(level.max_zoom,level.max_zoom)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_RIGHT:
		print("right mouse clicked")
		get_viewport().set_input_as_handled()
		if event.is_pressed():
			_previousPosition = event.position;
			_moveCamera = true;
		else:
			_moveCamera = false;
	elif event is InputEventMouseMotion && _moveCamera:
		print("right mouse draggging")
		get_viewport().set_input_as_handled()
		position += (_previousPosition - event.position);
		if position.x > 290.0:
			position.x = 290.0
		if position.x < -3250.0:
			position.x = -3250.0
		if position.y > 650.0:
			position.y = 650.0
		if position.y < -1360.0:
			position.y = -1360.0
		_previousPosition = event.position;
