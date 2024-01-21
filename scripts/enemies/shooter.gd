class_name Shooter
extends Marker2D


@export var bullet_scene: PackedScene

func shoot(direction: Vector2):
	var bullet: TrunkBullet = bullet_scene.instantiate()
	bullet.global_position = global_position
	bullet.scale.x = -direction.x
	get_tree().current_scene.add_child(bullet)
	#call_deferred("add_child", bullet)
	bullet.fire(direction)
	
