class_name Vision
extends Node2D


func _ready():
	owner.checks_disabled.connect(disable)


func disable():
	queue_free()


func can_move() -> bool:
	return true
