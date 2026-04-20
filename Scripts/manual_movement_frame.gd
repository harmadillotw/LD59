class_name MovementFrame


var type : int
var forward : Vector2
var rotate : float

func _init(t : int, f : Vector2, r : float) -> void:
	type = t
	forward = f
	rotate = r
