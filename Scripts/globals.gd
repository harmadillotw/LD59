extends Node


const MOVEMENT_TYPE_FORWARD = 0
const MOVEMENT_TYPE_ROTATE = 1 

var current_commands : Array[MovementCommand] = []

#UI values
var level_time_elapsed
var running_commands
