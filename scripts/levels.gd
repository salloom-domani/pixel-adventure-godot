extends  Control

@export var levels: Array[PackedScene]


func _ready() -> void:
	for child_idx in get_child_count():
		var button = get_child(child_idx) as Button
		button.connect("pressed", func(): _on_button_pressed(child_idx))
	get_child(0).grab_focus()


func _on_button_pressed(idx: int) -> void:
	get_tree().change_scene_to_packed(levels[idx])
