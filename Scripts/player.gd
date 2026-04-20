class_name Player
extends CharacterBody2D

@export var camera : Camera2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var notification_sprite_2d =$indicatorSprite2D

const SPEED = 75.0
const NORMAL_SPEED = 50.0
const SLOW_SPEED = 25.0
const FAST_SPEED = 100.0
#const JUMP_VELOCITY = -400.0
const DELAY_FRAMES = 60 # default frames per second is 60

var movement_mode = 0
var queue :Array[MovementFrame] = []
var cur_time = 0.0
var move_time = 0.0
var moving :bool = false
var player_speed = 0.0
var finish_zone : FinishZone

func _ready() -> void:
	var finish_zones = get_tree().get_nodes_in_group("finish_zone")
	finish_zone = finish_zones[0]
	#set the initial delay to the movement
	animated_sprite_2d.play("default")
	for i in range(DELAY_FRAMES):
		#print("Add delay frame %d" % i)
		var frame = MovementFrame.new(0,Vector2(0,0),0)
		queue.push_back(frame)

func _process(delta: float) -> void:
	var direction_to_end : Vector2= global_position.direction_to(finish_zone.global_position)
	notification_sprite_2d.look_at(finish_zone.global_position)
	#notification_sprite_2d.position = direction_to_end
	if moving:
		camera.position = position
	#if velocity == Vector2(0,0):
		#print("stopped")
func _physics_process(delta: float) -> void:
	if Globals.game_type == Globals.GAME_TYPE_COMMAND:
		# Move from commands
		move_by_commands(delta)
	elif Globals.game_type == Globals.GAME_TYPE_MANUAL:
		# Manula movement with delay
		move_by_delay(delta)
	
func move_by_commands(delta) -> void:
	#print("moving?: " + str(moving))
	if Globals.game_type == Globals.GAME_TYPE_COMMAND:
		if moving:
			#print("c" + str(cur_time) + " m" + str(move_time))	
			if cur_time < move_time:
				#print("move bigger")
				var remain = move_time - cur_time
				#print("remain:"+ str(remain))
				if remain >= delta:
					cur_time += delta
					#velocity.x +=(SPEED * delta)
					move_local_x(player_speed * delta)
				else:
					cur_time = move_time
					#velocity.x += (SPEED * remain)
					move_local_x(player_speed * remain)
			else:
				moving = false
				RoverAudioStreamPlayer.stop_rover_engine()
				animated_sprite_2d.play("default")
				velocity.x = 0.0
				GlobalSignals.movement_complete.emit()
				#send signal
			move_and_slide()
		#print("c" + str(cur_time) + " m" + str(move_time))	
	
	elif Globals.game_type == Globals.GAME_TYPE_MANUAL:
		# MOVE BY COMMAND
		var input_x : float = Input.get_axis("left", "right")
		
		rotation_degrees += 220.0 * delta * input_x
		if Input.is_action_pressed("up"):
			var dir: Vector2 = Vector2.from_angle(rotation)
			velocity = dir * SPEED
		else:
			
			velocity = Vector2(0,0)
		move_and_slide()
	
	
func move_by_delay(delta) -> void:
	#var direction := Input.get_vector("left", "right", "up", "down")
	#print("add frame")
	#queue.push_back(direction)
	#var apply_drection = queue.pop_front()
	#print("a")
	#print(apply_drection)
	#velocity = apply_drection * SPEED

	#move_and_slide()
	
	# MOVE BY COMMAND
	var input_x : float = Input.get_axis("left", "right")
	
	var new_rotation_degrees = 220.0 * delta * input_x
	#rotation_degrees = new_rotation_degrees
	var new_velocity
	if Input.is_action_pressed("up"):
		var dir: Vector2 = Vector2.from_angle(rotation)
		new_velocity = dir * SPEED
	else:
		new_velocity = Vector2(0,0)
	var frame = MovementFrame.new(0,new_velocity,new_rotation_degrees)
	queue.push_back(frame)
	var apply_drection : MovementFrame = queue.pop_front()
	var _play_audio = false
	if  apply_drection.rotate != 0.0:
		_play_audio = true
	if apply_drection.forward.x > 0.0:
		_play_audio = true
	if apply_drection.forward.y > 0.0:
		_play_audio = true
	if _play_audio:
		RoverAudioStreamPlayer.play_rover_engine()
	else:
		RoverAudioStreamPlayer.stop_rover_engine()
	rotation_degrees += apply_drection.rotate
	velocity = apply_drection.forward
	move_and_slide()
	
func rotate_player (r_deg : float) -> void:
	moving = true
	RoverAudioStreamPlayer.play_rover_engine()
	camera.position = position
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rotation_degrees", r_deg, 1.0)
	tween.tween_callback(_on_tween_finished)
	moving = false
	#RoverAudioStreamPlayer.stop_rover_engine()
	#rotation_degrees +=  r_deg
	GlobalSignals.movement_complete.emit()
	
func player_forward (f_sec : float, i_speed : int) -> void:
	cur_time = 0.0
	move_time = f_sec
	if i_speed == 0:
		player_speed = SLOW_SPEED
	if i_speed == 1:
		player_speed = NORMAL_SPEED
	if i_speed == 2:
		player_speed = FAST_SPEED
	#player_speed = f_speed
	moving = true
	RoverAudioStreamPlayer.play_rover_engine()
	animated_sprite_2d.play("moving")
	print("do forwards cur_time:" + str(cur_time) + " move_time:"+ str(move_time) + " moving:" + str(moving))
	
func _on_tween_finished() -> void:
	RoverAudioStreamPlayer.stop_rover_engine()
		
