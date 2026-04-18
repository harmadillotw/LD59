class_name MovementCommand

var movement_type
var speed
var duration
var rotate_degrees

func _init( m,s,d,r) -> void:
	movement_type = m
	speed = s
	duration = d
	rotate_degrees = r
