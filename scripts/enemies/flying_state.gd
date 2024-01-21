@tool
class_name FlyingState
extends StateAnimation


@onready var dust_move_particles = %DustMoveParticles
@onready var vision = %Vision

@export var max_speed = 50
@export var acceleration = 5

var tween: Tween

func enter(args = {}):
	super.enter(args)
	await get_tree().create_timer(.25).timeout
	dust_move_particles.emitting = true
	tween = create_tween().set_loops()
	tween.tween_property(character, "position:y", character.position.y + 5, .25)
	tween.tween_property(character, "position:y", character.position.y - 5, .2)


func phy_update(delta):
	if not vision.can_move():
		character.direction *= -1
		character.flip()
	else:
		character.velocity.x += acceleration * character.direction
		if abs(character.velocity.x) > max_speed:
			character.velocity.x = max_speed * character.direction

		#character.velocity.x = speed * character.direction


func exit():
	super.exit()
	dust_move_particles.emitting = false
	tween.kill()

func _init():
	id = "fly"
