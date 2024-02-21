extends Node2D

@export var child: PackedScene

func spawn():
	
	var child_one = child.instantiate()
	var child_two = child.instantiate()
	
	child_one.global_position = global_position
	child_two.global_position = global_position
	
	child_one.flip_for_direction(1)
	get_parent().add_sibling.call_deferred(child_one)
	get_parent().add_sibling.call_deferred(child_two)
