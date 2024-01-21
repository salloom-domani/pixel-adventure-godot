extends Node

var first_chapter: LevelsMenu = load("res://resources/first_chapter.tres")
var second_chapter: LevelsMenu = load("res://resources/second_chapter.tres")

signal camera_shaked
signal scene_changed(idx, chapter)

func _ready():
	scene_changed.connect(on_scene_change)


func on_scene_change(idx: int, chapter: int):
	var level = null
	match chapter:
		1:
			level = first_chapter.get_level(idx)
		2:
			level = second_chapter.get_level(idx)
	if level:
		get_tree().change_scene_to_packed(level)
