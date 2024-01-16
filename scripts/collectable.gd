@tool
extends RigidBody2D

@onready var animator = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D

enum FruitType {
	Apple,
	Banana,
	Cherry,
	Kiwi,
	Melon,
	Pineapple,
	Orange,
	Strawberry
}

@export var fruit_type: FruitType = FruitType.Apple: set = set_type

@export var explode_power = 100

func set_type(val):
	fruit_type = val
	if animator:
		animator.animation =str(FruitType.keys()[fruit_type]).to_lower()


func pick_random_type():
	fruit_type = FruitType.values().pick_random()


func explode():
	var angle = randf_range(PI,2*PI)
	self.apply_central_impulse(Vector2.from_angle(angle) * explode_power)



func _ready() -> void:
	animator.animation =str(FruitType.keys()[fruit_type]).to_lower()


func _on_animated_sprite_2d_animation_finished():
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		animator.animation = "collected"
		#collision_shape_2d.disable d = true
