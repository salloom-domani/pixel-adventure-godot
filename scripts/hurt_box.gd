class_name HurtBox
extends Area2D

func _ready():
	area_entered.connect(_on_area_enter)


func _on_area_enter(hit_box: Area2D):
	pass


func take_damage(direction: Vector2):
	owner.die(direction)
