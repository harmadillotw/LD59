extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var level : Level =Level.new("Lab1 - Transverse","res://Scenes/Level_1.tscn", 0.35)
	Globals.command_levels.push_back(Level.new("Lab1 - Transverse","res://Scenes/Level_1.tscn", 0.35))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	Globals.current_level = 0
	get_tree().change_scene_to_file(Globals.levels[Globals.current_level])


func _on_exit_button_pressed() -> void:
	get_tree().quit()
