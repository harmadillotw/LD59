extends Node2D

@onready var instructions_button : CheckButton =$Panel/VBoxContainer/Panel2/InstructionsCheckButton
@onready var command_button : CheckButton = $Panel/VBoxContainer/Panel/HBoxContainer/CommandCheckButton
@onready var manual_button : CheckButton = $Panel/VBoxContainer/Panel/HBoxContainer/ManualCheckButton
@onready var player : CharacterBody2D =$Panel/Player
@onready var player_animated_sprite : AnimatedSprite2D = $Panel/Player/AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	instructions_button.button_pressed = true
	command_button.button_pressed = true
	manual_button.button_pressed = false
	#var level : Level =Level.new("Lab1 - Transverse","res://Scenes/Level_1.tscn", 0.35)
	#Globals.command_levels.push_back(Level.new("Moon1 - Transverse","","res://Scenes/Moon/Level_Moon_1.tscn", 0.25))
	Globals.command_levels.push_back(Level.new("Lab1 - Transverse","A simple forward command should do the trick","res://Scenes/Level_1.tscn", 0.35))
	Globals.command_levels.push_back(Level.new("Lab2 - Rotate","Two steps are required","res://Scenes/Level_2.tscn", 0.35))
	Globals.command_levels.push_back(Level.new("Lab1 - Obstacle","Can't go through. Will have to go around","res://Scenes/Level_3.tscn", 0.35))
	Globals.command_levels.push_back(Level.new("Moon1 - Transverse","Untested","res://Scenes/Moon/Level_Moon_1.tscn", 0.25))
	Globals.command_levels.push_back(Level.new("Mars1 - Transverse","Untested","res://Scenes/Mars/Level_Mars_1.tscn", 0.25))
	
	Globals.manual_levels.push_back(Level.new("Lab1 - Transverse","Just move forward","res://Scenes/Level_M1.tscn", 0.35))
	Globals.manual_levels.push_back(Level.new("Lab1 - Rotate","Forward and a turn","res://Scenes/Level_M2.tscn", 0.35))
	player_animated_sprite.play("moving")
	_rover_commands()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_start_button_pressed() -> void:
	if instructions_button.button_pressed:
		pass
	Globals.current_level = 0
	if command_button.button_pressed:
		Globals.game_type = Globals.GAME_TYPE_COMMAND
		#get_tree().change_scene_to_file(Globals.command_levels[Globals.current_level].level_link)
	else:
		Globals.game_type = Globals.GAME_TYPE_MANUAL
		#get_tree().change_scene_to_file(Globals.manual_levels[Globals.current_level].level_link)
	get_tree().change_scene_to_file("res://Scenes/StartLevel.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_command_check_button_pressed() -> void:
	manual_button.button_pressed = !command_button.button_pressed


func _on_manual_check_button_pressed() -> void:
	command_button.button_pressed = !manual_button.button_pressed
	
func _rover_commands() -> void:
	var tween = get_tree().create_tween()

	for i in range(1000):
		tween.tween_property(player, "position", Vector2(500,350), 1.0)
		tween.tween_property(player, "rotation_degrees",90.0, 1.0)
		tween.tween_property(player, "position", Vector2(500,500), 1.0)
		tween.tween_property(player, "rotation_degrees", 180.0, 1.0)
		tween.tween_property(player, "position", Vector2(350,500), 1.0)
		tween.tween_property(player, "rotation_degrees", 270.0, 1.0)
		tween.tween_property(player, "position", Vector2(350,350), 1.0)
		tween.tween_property(player, "rotation_degrees", 0.0, 1.0)
	


func _on_options_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Options.tscn")
