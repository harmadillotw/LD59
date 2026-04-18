class_name FinishZone
extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func test_object_in_zone() -> bool:
	var o_bodies : Array[Node2D] = self.get_overlapping_bodies()
	var o_areas = self.get_overlapping_areas()
	if o_bodies.size() > 0:
		if o_bodies[0].is_in_group("player"):
			return true
	return false
	#print("bodies: " + str(o_bodies.size()) + " areas: " + str(o_areas.size()) )
