extends Node


const MOVEMENT_TYPE_FORWARD = 0
const MOVEMENT_TYPE_ROTATE = 1 

const GAME_TYPE_COMMAND = 0
const GAME_TYPE_MANUAL = 1

var current_commands : Array[MovementCommand] = []
var game_type
#UI values
var level_time_elapsed
var running_commands
var current_level
var levels = ["res://Scenes/Level_M1.tscn"]
#var levels = ["res://Scenes/Level_1.tscn", "res://Scenes/Level_2.tscn","res://Scenes/Level_3.tscn"]
