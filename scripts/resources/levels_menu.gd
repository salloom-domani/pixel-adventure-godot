class_name LevelsMenu
extends Resource

@export var levels: Array[PackedScene]

func get_next_level(current_idx: int):
	return levels[current_idx + 1]

func get_prev_level(current_idx: int):
	return levels[current_idx - 1]

func get_level(idx: int):
	if idx >= 0 and idx < levels.size():
		return levels[idx]
