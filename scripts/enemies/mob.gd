class_name Mob
extends CharacterBody2D


@onready var state_machine = $MobStateMachine
@onready var collision = $CollisionShape2D
#@onready var vision = %Vision

var bogo_jump = -200

@export var direction = -1
@export var to_flip: Node2D

signal checks_disabled
signal target_died

func _physics_process(delta):
	move_and_slide()

func disable_checks():
	collision_layer = 0
	collision_mask = 0
	checks_disabled.emit()
	#vision.queue_free()

func flip():
	to_flip.apply_scale(Vector2(-1, 1))

func flip_for_direction(dir: int):
	to_flip.scale = Vector2(-dir, 1)
	to_flip.rotation = 0
	direction = dir

func die(dir: Vector2):
	state_machine.set_state("dead", {"direction": dir})

func is_directly_below(other: Vector2, width: float):
	return other.x > collision.global_position.x - collision.shape.extents.x - width \
		and other.x < collision.global_position.x + collision.shape.extents.x + width \
		and other.y < collision.global_position.y - collision.shape.extents.y
