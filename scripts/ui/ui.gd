extends CanvasLayer

@export var chapter = 1
@export var current_level_id: int

func _on_back_button_pressed() -> void:
	#var prev_level = levels.get_prev_level(current_level_id - 1)
	#get_tree().change_scene_to_packed(prev_level)
	var prev_level_idx = current_level_id - 1 - 1
	Global.scene_changed.emit(prev_level_idx, chapter)


func _on_next_button_pressed() -> void:
	#var next_level = levels.get_next_level(current_level_id - 1)
	#get_tree().change_scene_to_packed(next_level)
	var next_level_idx = current_level_id - 1 + 1
	Global.scene_changed.emit(next_level_idx, chapter)


func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()
