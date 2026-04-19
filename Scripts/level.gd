class_name Level
extends Resource

var level_description : String
var level_link : String
var max_zoom: float

func _init(ld : String, ll : String, mz: float) -> void:
	level_description = ld
	level_link = ll
	max_zoom = mz
