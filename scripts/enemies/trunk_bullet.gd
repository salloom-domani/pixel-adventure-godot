class_name TrunkBullet
extends RigidBody2D

@export var parts_scene: PackedScene

@export var speed: int = 200


func break_it():
	var parts = parts_scene.instantiate()
	call_deferred("add_sibling", parts)
	parts.position = position
	parts.explode(150)
	queue_free()

func fire(direction: Vector2):
	linear_velocity = direction * speed


func _on_body_entered(body):
	if body.is_in_group("player"):
		var direction = (body.position - position).normalized()
		body.die(Vector2.RIGHT * direction.x)
	break_it()
