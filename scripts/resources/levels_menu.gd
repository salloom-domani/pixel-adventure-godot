class_name LevelsMenu
extends Resource

@export var levels: Array[PackedScene]

func get_next_level(current_idx: int):
	return levels[current_idx + 1]

func get_prev_level(current_idx: int):
	return levels[current_idx - 1]
