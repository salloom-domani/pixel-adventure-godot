extends Control

@export var levels_menu = load("res://levels.tres")
var level_string: String

func _input(event):
	if int(event.as_text()):
		level_string += event.as_text()
	if event.is_action_pressed("ui_accept"):
		var level_id = int(level_string)
		var level = levels_menu.levels[level_id - 1]
		level_string = ""
		get_tree().change_scene_to_packed(level)
