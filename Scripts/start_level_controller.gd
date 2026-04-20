extends Node2D

@onready var title_label = $Panel/TitleLabel
@onready var description_label = $Panel/Label
@onready var instr_header = $Panel/Label2
@onready var instr_label = $Panel/Label3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Globals.game_type == Globals.GAME_TYPE_COMMAND:
		title_label.text = Globals.command_levels[Globals.current_level].level_title
		description_label.text = Globals.command_levels[Globals.current_level].level_description
	else:
		title_label.text = Globals.manual_levels[Globals.current_level].level_title
		description_label.text = Globals.manual_levels[Globals.current_level].level_description
	if Globals.current_level == 0:
		instr_header.visible = true
		instr_label.visible = true
		if Globals.game_type == Globals.GAME_TYPE_COMMAND:
			instr_label.text = Globals.instructions_command
		else:
			instr_label.text = Globals.instructions_manual
	else:
		instr_header.visible = false
		instr_label.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	if Globals.game_type == Globals.GAME_TYPE_COMMAND:
		get_tree().change_scene_to_file(Globals.command_levels[Globals.current_level].level_link)
	else:
		get_tree().change_scene_to_file(Globals.manual_levels[Globals.current_level].level_link)
