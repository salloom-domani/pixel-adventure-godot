extends Area2D


func get_collided_boxes():
	return get_overlapping_bodies().filter(func(b): return b is Box)
