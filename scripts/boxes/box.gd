class_name Box
extends StaticBody2D

@onready var animator: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

@export var parts: PackedScene
@export var fruit: PackedScene
@export var health = 1
@export var fruits_count = 3
@export var one_by_one = false
@export var jump_speed = -300

var broken = false

func hit():
	Global.camera_shaked.emit()
	health -= 1
	animator.play("hit")
	if one_by_one:
		fruits_count -= 1
		spawn_fruits(1)
	if health <= 0:
		broken = true


func break_it():
	collision_layer = 0
	collision_mask = 0
	spawn_parts()
	spawn_fruits(fruits_count)
	queue_free()


func spawn_parts():
	var instance = parts.instantiate()
	add_sibling(instance)
	instance.position = position
	instance.explode(150)

func spawn_fruits(count: int):
	for i in range(count):
		var new_fruit = fruit.instantiate()
		add_sibling(new_fruit)
		new_fruit.pick_random_type()
		new_fruit.position.x = position.x + randf_range(-1,1)
		new_fruit.position.y = position.y
		new_fruit.explode()
		
	


func random_numbers(count: int, to = count - 1, from = 0):
	var numbers = {}
	while numbers.size() < count:
		var random_number = randi_range(from, to)
		numbers[random_number] = null
	return numbers.keys()


func is_directly_on_top_or_down(other: Vector2, width: float):
	return other.x > position.x - collision.shape.extents.x - width \
			and other.x < position.x + collision.shape.extents.x + width \
			and (other.y > position.y + collision.shape.extents.y \
			or other.y < position.y - collision.shape.extents.y)



func _on_animated_sprite_2d_animation_finished() -> void:
	if broken:
		break_it()
	animator.animation = "default"
