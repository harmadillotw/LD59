extends Node2D

const COMMAND_DELAY = 1.5
var player : Player
var finish_zone : FinishZone
var moving = false;
var commands : Array[MovementCommand] = []
var count_time = false
var player_start_position : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.level_time_elapsed = 0.0
	count_time = false
	GlobalSignals.movement_complete.connect(_process_movement_complete)
	GlobalSignals.restart_level.connect(_process_restart_level)
	GlobalSignals.start_movement.connect(_process_start_movement)
	var players = get_tree().get_nodes_in_group("player")
	player = players[0]
	#player_start_position = Vector2(player.position.x,player.position.y)
	player_start_position = player.position
	var finish_zones = get_tree().get_nodes_in_group("finish_zone")
	finish_zone = finish_zones[0]
	commands = Globals.current_commands
	#commands.push_back(MovementCommand.new(Globals.MOVEMENT_TYPE_FORWARD,50,1,0))
	#commands.push_back(MovementCommand.new(Globals.MOVEMENT_TYPE_ROTATE,0,0,90))
	#commands.push_back(MovementCommand.new(Globals.MOVEMENT_TYPE_FORWARD,50,2,0))
	moving = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if count_time:
		Globals.level_time_elapsed += delta
	
func _input(event: InputEvent) -> void:
	if moving:
		pass
	else:
		if event.is_action_released("rotate"):
			moving = true
			player.rotate_player(90.0)
		if event.is_action_released("forward"):
			moving = true
			player.player_forward(8, 100)
		#if event.is_action_released("start"):
		#	_start_movement()
			
func _start_movement() -> void:
	if commands.size() > 0:
		GlobalSignals.run_commands.emit()
		count_time = true
		_process_movement_commands(false)

func _process_movement_commands(include_delay : bool) -> void:
	# delay between command. Fewer commands is better.
	if include_delay:
		await get_tree().create_timer(COMMAND_DELAY).timeout
	var command : MovementCommand = commands.pop_front()
	GlobalSignals.process_command.emit(command)
	if command.movement_type == Globals.MOVEMENT_TYPE_FORWARD:
		print("Forwards")
		moving = true
		player.player_forward(command.duration, command.speed)
	elif command.movement_type == Globals.MOVEMENT_TYPE_ROTATE:
		moving = true
		print("Rotate")
		player.rotate_player(command.rotate_degrees)
	#var command = commands.pop_front()
 	#if command.movement_type == Globals.MOVEMENT_TYPE_FORWARD:
	#	player.player_forward(command.duration, command.speed)
	#elif command.movement_type == Globals.MOVEMENT_TYPE_ROTATE:
	#	player.rotate_player(command.rotate_degrees)
	#else:
	#	print("Unknon movement type, skipping")
func _process_movement_complete() -> void:
	if finish_zone.test_object_in_zone():
		count_time = false
		print("Finished")
		GlobalSignals.level_complete.emit()
		#exit level
	else:
		print("Not Finished")
		moving = false
		if commands.size() > 0:
			_process_movement_commands(true)

func _process_restart_level() -> void:
	Globals.level_time_elapsed = 0.0
	count_time = false
	commands.clear()
	player.position = player_start_position
	
func _process_start_movement() -> void:
	commands = Globals.current_commands.duplicate()
	_start_movement()
	
