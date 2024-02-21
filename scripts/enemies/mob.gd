class_name Mob
extends CharacterBody2D


@onready var state_machine = $MobStateMachine
@onready var collision = $CollisionShape2D
#@onready var vision = %Vision
@onready var hit_box_collision = %HitBox/CollisionShape2D
@onready var hurt_box_collision = %HurtBox/CollisionShape2D

var bogo_jump = -350
var should_bogo_jump = true
var bogo_acceptable_miss = .2

@export var direction = -1
@export var to_flip: Node2D

signal checks_disabled
signal target_died

func _physics_process(delta):
	move_and_slide()

func disable_checks():
	collision.set_deferred("disabled", true)
	hit_box_collision.set_deferred("disabled", true)
	hurt_box_collision.set_deferred("disabled", true)
	checks_disabled.emit()
	#vision.queue_free()

func flip():
	to_flip.apply_scale(Vector2(-1, 1))

func flip_for_direction(dir: int):
	to_flip.scale = Vector2(-dir, 1)
	to_flip.rotation = 0
	direction = dir

func die(hit_dir: Vector2):
	state_machine.set_state("dead", {"direction": hit_dir * -1})

func is_directly_below(other: Vector2, width: float):
	var collision_width = collision.shape.extents.x 
	var collision_height = collision.shape.extents.y
	var pos_x = collision.global_position.x
	var pos_y = collision.global_position.y + bogo_acceptable_miss
	return other.x > pos_x - collision_width - width \
		and other.x < pos_x + collision_height + width \
		and other.y < pos_y - collision_height


# FIXME: this need to consider the lowest point of the player
# rather than the collsion point which could not be predicted
func should_die(collision_point: Vector2):
	var collision_height = collision.shape.extents.y
	return collision_point.y < collision.global_position.y \
		- collision_height * ( 1 - bogo_acceptable_miss )
