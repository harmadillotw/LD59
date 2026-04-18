extends Node2D

@export var time_label : Label 
@export var running_label : Label 
@export var type_option_button: OptionButton
@export var duration_label : Label
@export var duration_text : TextEdit
@export var speed_label : Label
@export var speed_option_button: OptionButton
@export var degrees_label : Label
@export var degrees_text : TextEdit
@export var commands_vbox : VBoxContainer
@export var active_command_label : Label
@export var level_complete_panel : Panel

var pre_commands : Array[MovementCommand] = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# signals
	GlobalSignals.run_commands.connect(_process_run_commands)
	GlobalSignals.process_command.connect(_process_process_command)
	GlobalSignals.level_complete.connect(_process_level_complete)
	var format_string = "%.2f"
	var display_string = format_string % 0.0
	time_label.text = display_string
	running_label.text = "Enter Commands"
	type_option_button.selected = 0
	degrees_label.visible = false
	degrees_text.visible = false
	speed_option_button.selected = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var format_string = "%.2f"
	var display_string = format_string % Globals.level_time_elapsed
	time_label.text = display_string


# Handle Signals
func _process_run_commands() -> void:
	running_label.text = "Running Commands"

func _process_process_command(command: MovementCommand) -> void:
	active_command_label.text = command._to_string()
	
func _process_level_complete() -> void:
	level_complete_panel.visible = true
#UI Controlls
func _on_type_option_button_item_selected(index: int) -> void:
	if index == 0:
		duration_label.visible = true
		duration_text.visible = true
		speed_label.visible = true
		speed_option_button.visible = true
		degrees_label.visible = false
		degrees_text.visible = false
	else:
		duration_label.visible = false
		duration_text.visible = false
		speed_label.visible = false
		speed_option_button.visible = false
		degrees_label.visible = true
		degrees_text.visible = true
		


func _on_add_command_button_pressed() -> void:
	if type_option_button.selected == 0:
		var new_command = MovementCommand.new(type_option_button.selected,speed_option_button.selected,duration_text.text.to_float(),0)
		Globals.current_commands.push_back(new_command)
		var test = Label.new()
		test.text = new_command.to_string()
		commands_vbox.add_child(test)
	if type_option_button.selected == 1:
		var new_command = MovementCommand.new(type_option_button.selected,0,0,degrees_text.text.to_float())
		var test = Label.new()
		test.text = new_command.to_string()
		commands_vbox.add_child(test)
		Globals.current_commands.push_back(new_command)


func _on_clear_commands_button_pressed() -> void:
	pass # Replace with function body.


func _on_clear_button_pressed() -> void:
	for child in commands_vbox.get_children():
		child.queue_free()
	Globals.current_commands.clear()


func _on_reset_level_button_pressed() -> void:
	_on_clear_button_pressed()
	active_command_label.text = ""
	GlobalSignals.restart_level.emit()
	

func _on_start_button_pressed() -> void:
	GlobalSignals.start_movement.emit()


func _on_restart_button_pressed() -> void:
	level_complete_panel.visible = false
	_on_reset_level_button_pressed()


func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")


func _on_next_level_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
