extends Node2D

var player : Player
var finish_zone : FinishZone
var moving = false;
var commands : Array[MovementCommand] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalSignals.movement_complete.connect(_process_movement_complete)
	var players = get_tree().get_nodes_in_group("player")
	player = players[0]
	var finish_zones = get_tree().get_nodes_in_group("finish_zone")
	finish_zone = finish_zones[0]
	commands.push_back(MovementCommand.new(Globals.MOVEMENT_TYPE_FORWARD,50,2,0))
	commands.push_back(MovementCommand.new(Globals.MOVEMENT_TYPE_ROTATE,0,0,90))
	commands.push_back(MovementCommand.new(Globals.MOVEMENT_TYPE_FORWARD,50,4,0))
	moving = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
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
		if event.is_action_released("start"):
			_start_movement()
			
func _start_movement() -> void:
	if commands.size() > 0:
		_process_movement_commands()

func _process_movement_commands() -> void:
	var command : MovementCommand = commands.pop_front()
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
		print("Finished")
		#exit level
	else:
		print("Not Finished")
		moving = false
		if commands.size() > 0:
			_process_movement_commands()
