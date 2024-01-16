class_name Fire
extends StaticBody2D

@onready var area_2d: Area2D = $Area2D
@onready var animator: AnimatedSprite2D = $AnimatedSprite2D
@onready var delay_timer: Timer = $DelayTimer
@onready var on_timer: Timer = $OnTimer

func hit():
	animator.play("hit")
	delay_timer.start()


func _on_delay_timer_timeout() -> void:
	area_2d.monitoring = true
	animator.play("on")
	on_timer.start()


func _on_on_timer_timeout() -> void:
	area_2d.monitoring = false
	animator.play("off")


func _on_area_2d_body_entered(body: Node2D) -> void:
	var direction = (body.position - position).normalized()
	body.die(direction)
