class_name MovementCommand

var movement_type
var speed : int
var duration : float
var rotate_degrees : float

func _init( m,s : int,d : float,r : float) -> void:
	movement_type = m
	speed = s
	duration = d
	rotate_degrees = r
	
func _to_string() -> String:
	var display : String = ""
	if movement_type == 0:
		display = "FORWARD"
		if speed == 0:
			display += " at 25kph"
		elif speed == 1:
			display += " at 50kph"
		elif speed == 2:
			display += " at 100kph"
		display += " for " + str(duration) + " s"
	elif movement_type == 1:
		display = "ROTATE " + str(rotate_degrees) + " degrees"
		
	return display
