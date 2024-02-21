class_name HitBox
extends Area2D


func _ready():
	area_entered.connect(_on_area_enter)


func _on_area_enter(area: Area2D):
	var direction = (area.owner.position - owner.position).normalized()
	if area is HurtBox:
		area.take_damage(direction)
	
	if owner.has_signal("target_died"):
		owner.target_died.emit()
	
	# FIXME: find a way to skip the bogo jump when snail is idle
	# something like area.owner.should_bogo_jump
	if owner.has_method("bogo_jump") and area.owner.should_bogo_jump:
		owner.bogo_jump(area.owner.bogo_jump)
