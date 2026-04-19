extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _draw() -> void:
	draw_line(Vector2(0.0, 0.0), Vector2(0.0, 20), Color.GREEN, 2.0)
	draw_line(Vector2(420.0, 300.0), Vector2(430, 300), Color.GREEN, 10.0)
