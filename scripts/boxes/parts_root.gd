class_name PartsRoot
extends Node2D


func explode(power: int):
	for child in get_children():
		if child is Part:
			var random = randf_range(PI, 2 * PI)
			child.explode(Vector2.from_angle(random) * power)
