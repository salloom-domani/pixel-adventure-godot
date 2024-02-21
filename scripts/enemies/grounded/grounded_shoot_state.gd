@tool
class_name GroundedShootState
extends StateAnimation

@onready var shooter = %Shooter

@export var shoot_frame = 8
@export var shoot_delay = 0.3

var should_exit = false

func enter(args = {}):
	super.enter(args)
	should_exit = false
	character.velocity.x = 0
	animated_sprite.frame_changed.connect(on_frame_changed)
	animated_sprite.animation_finished.connect(on_animation_finished)


func on_frame_changed():
	if animated_sprite.frame == shoot_frame:
		attack()

func on_animation_finished():
	if should_exit:
		parent.set_state("idle")
		return
	add_default_timer(shoot_delay, func(): animated_sprite.play("attack"))
	#await get_tree().create_timer(shoot_delay).timeout
	#animated_sprite.play("attack")


func attack():
	shooter.shoot(character.direction * Vector2.RIGHT)


func _on_player_detector_body_exited(body):
	if body.is_in_group("player"):
		should_exit = true


func exit():
	super.exit()
	animated_sprite.frame_changed.disconnect(on_frame_changed)
	animated_sprite.animation_finished.disconnect(on_animation_finished)
	del_default_timer()
