class_name Platform
extends Node2D

@onready var line_2d: Line2D = $Line2D
@onready var path_2d: Path2D = $Path2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func turn_on():
	animation_player.play("default")


func turn_off():
	animation_player.play_backwards("default")
