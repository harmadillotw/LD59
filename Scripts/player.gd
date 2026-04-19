class_name Player
extends CharacterBody2D

@export var camera : Camera2D

@onready var animated_sprite_2d = $AnimatedSprite2D

const SPEED = 50.0
const NORMAL_SPEED = 50.0
const SLOW_SPEED = 25.0
const FAST_SPEED = 100.0
#const JUMP_VELOCITY = -400.0
const DELAY_FRAMES = 60 # default frames per second is 60

var movement_mode = 0
var queue = []
var cur_time = 0.0
var move_time = 0.0
var moving :bool = false
var player_speed = 0.0

func _ready() -> void:
	#set the initial delay to the movement
	animated_sprite_2d.play("default")
	for i in range(DELAY_FRAMES):
		queue.push_back(Vector2(0,0))

func _process(delta: float) -> void:
	camera.position = position
	if velocity == Vector2(0,0):
		print("stopped")
func _physics_process(delta: float) -> void:
	if movement_mode == 0:
		# Move from commands
		move_by_commands(delta)
	elif movement_mode == 1:
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
	var direction := Input.get_vector("left", "right", "up", "down")
	queue.push_back(direction)
	var apply_drection = queue.pop_front()
	print("a")
	print(apply_drection)
	velocity = apply_drection * SPEED

	move_and_slide()
	
func rotate_player (r_deg : float) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rotation_degrees", r_deg, 1.0)
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
	animated_sprite_2d.play("moving")
	print("do forwards cur_time:" + str(cur_time) + " move_time:"+ str(move_time) + " moving:" + str(moving))
	
		
