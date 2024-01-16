class_name Arrow
extends Area2D


@onready var animator: AnimatedSprite2D = $AnimatedSprite2D
@export var jump_speed = -400


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.camera_shaked.emit()
		animator.animation = "hit"
		body.state_machine.set_state("in_air/jump", { "jump_speed": jump_speed })


func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
