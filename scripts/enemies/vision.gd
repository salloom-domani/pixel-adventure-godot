class_name Vision
extends Node2D


var parent: Mob

func _ready():
	parent = owner
	parent.checks_disabled.connect(disable)


func disable():
	queue_free()


func can_move() -> bool:
	return true
