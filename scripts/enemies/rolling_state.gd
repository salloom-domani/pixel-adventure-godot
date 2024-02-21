class_name RollingState
extends State

@onready var vision: Vision = %Vision
@onready var hit_particles = %HitParticles

@export var speed = 250


func enter(args = {}):
	super.enter(args)
	var new_direction = sign(args["direction"].x) if args.has("direction") else character.direction
	character.flip_for_direction(new_direction)
	character.direction = new_direction
	animator.animation_finished.connect(_on_animation_finish)
	animator.play("shell_hit_top")


func _on_animation_finish():
	animator.play("shell_move")

func phy_update(delta):
	if vision.hit_wall():
		character.direction *= -1
		animator.play("shell_hit_wall")
		Global.camera_shaked.emit()
		character.flip()
		hit_particles.restart()
	else:
		character.velocity.x = speed * character.direction


func exit():
	super.exit()

func _init():
	id = "roll"
