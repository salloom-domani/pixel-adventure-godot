class_name Part
extends RigidBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D

var blink_timer: Timer
var grounded = false
var exploded = false


func explode(force: Vector2):
	apply_central_impulse(force)
	exploded = true


func _ready() -> void:
	blink_timer = Timer.new()
	
	blink_timer.wait_time = 0.1
	blink_timer.timeout.connect(blink)
	add_child(blink_timer)

func destroy():
	await get_tree().create_timer(1).timeout
	remove_child(blink_timer)
	queue_free()

func blink():
	sprite_2d.visible = not sprite_2d.visible

func _process(delta: float) -> void:
	if linear_velocity.is_zero_approx():
		if exploded and blink_timer.is_stopped():
			blink_timer.start()
			destroy()
