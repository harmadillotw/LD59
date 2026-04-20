extends Node


const MOVEMENT_TYPE_FORWARD = 0
const MOVEMENT_TYPE_ROTATE = 1 

const GAME_TYPE_COMMAND = 0
const GAME_TYPE_MANUAL = 1

var musicVolume = 0.0
var fxVolume = 0.0

var current_commands : Array[MovementCommand] = []
var game_type
#UI values
var level_time_elapsed
var running_commands
var current_level

var command_levels : Array[Level] = []
var manual_levels : Array[Level] = []

#var levels = ["res://Scenes/Level_M1.tscn"]
var levels = ["res://Scenes/Mars/Level_Mars_1.tscn"]
#var levels = ["res://Scenes/Level_1.tscn", "res://Scenes/Level_2.tscn","res://Scenes/Level_3.tscn"]

var instructions_command = "Select and add Forward and Rotate commands until the rover ends a command wihin the mission end zone.\nThe signal to the rover has limitted bandwidth. Only 5 commands can be sent at a time.\nCamera pan - right mouse button.           Camera zoom - mouse wheel"

var instructions_manual = "Manually drive the rover. There is a delay in the input signal reaching the rover.\nForward - w\nRotate right - d           Rotate left - a\nCamera pan - right mouse button.           Camera zoom - mouse wheel"
