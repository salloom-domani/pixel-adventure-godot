@tool
extends Area2D

@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var animator: AnimatedSprite2D = $AnimatedSprite2D
@onready var particles: CPUParticles2D = $CPUParticles2D

@export_range(1, 50, 1, "suffix:Blocks") var tall:get = get_tall, set = set_tall
@export var turned_on: bool = false

var target: CharacterBody2D
var direction: Vector2i

func get_tall():
	if collision:
		return collision.shape.extents.y / 8

func set_tall(v):
	if collision:
		var size_y = v * 8
		collision.position.y = 4 - size_y
		collision.shape.extents = Vector2(collision.shape.extents.x, size_y)
		collision.shape.property_list_changed.emit()
		tall = v


func up():
	return Vector2.from_angle(rotation - PI / 2)

func _ready() -> void:
	var size_y = tall * 8
	collision.position.y = 4 - size_y
	collision.shape.extents = Vector2(collision.shape.extents.x, size_y)
	animator.animation = "on" if turned_on else "off"
	particles.emitting = turned_on
	direction = self.up()

func _on_timer_timeout() -> void:
	turned_on = not turned_on
	particles.emitting = turned_on
	animator.animation = "on" if turned_on else "off"


func _physics_process(delta: float) -> void:
	if not Engine.is_editor_hint():
		var input = Input.get_axis("left", "right")
		if target and turned_on:
			if abs(direction.x) != 0:
				target.velocity.x = direction.x * 50 + input * 70
			elif abs(direction.y) != 0:
				target.velocity.y = direction.y * 200


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		target = body


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		target = null
