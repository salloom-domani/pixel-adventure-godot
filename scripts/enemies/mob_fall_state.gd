class_name MobFallState
extends State

@export var gravity = 1200

var gravity_enabled = false

func enter(args = {}):
	super.enter(args)
	animator.play("hit")
	await get_tree().create_timer(.05).timeout
	gravity_enabled = true


func phy_update(delta):
	if character.is_on_floor():
		parent.set_state("idle")
	if gravity_enabled:
		character.velocity.y += gravity * delta


func _init():
	id = "fall"
