extends AnimatableBody2D


@export var direction = Vector2(1, 0)
@export var in_circle = false
@export var max_speed = 5
@export var acceleration = 0.2

@onready var wait_timer: Timer = $WaitTimer
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var animator: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var speed = 0
var wait = false


func _physics_process(delta: float) -> void:
	if speed > max_speed:
		speed = max_speed
	if not wait:
		speed += acceleration
		move_and_collide(direction * speed)
	if ray_cast_2d.get_collider() and wait_timer.is_stopped():
		hit_wall()


func hit_wall():
	wait = true
	speed = 0
	Global.camera_shaked.emit()
	animate(ray_cast_2d.get_collision_normal())
	self.position = ray_cast_2d.get_collision_point() - direction * collision_shape_2d.shape.extents.x
	change_direction()
	wait_timer.start()

func animate(hit_direction):
	match hit_direction:
		Vector2(-1,0):
			animator.play("hit_right")
		Vector2(1,0):
			animator.play("hit_left")
		Vector2(0,1):
			animator.play("hit_top")
		Vector2(0,-1):
			animator.play("hit_bottom")
		
	

func change_direction():
	if not in_circle:
		direction *= -1
	else:
		direction = direction.rotated(PI / 2)
	ray_cast_2d.target_position = direction * 24

func _on_wait_timer_timeout() -> void:
	wait = false
	animator.play("blink")


func _on_animated_sprite_2d_animation_finished() -> void:
	animator.play("idle")
