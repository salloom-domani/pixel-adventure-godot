class_name DeadState
extends PlayerState


var clock_wise = false

func enter(args = {}):
	Global.camera_shaked.emit()
	character.disable_checks()
	animator.animation = "hit"
	character.velocity = Vector2.ZERO
	character.collision_layer = 0
	character.collision_mask = 0
	var direction = args["direction"] as Vector2
	if direction.x > 0:
		clock_wise = true
	character.velocity.x = direction.x * 100
	if direction.y <= 0:
		character.velocity.y = -250


func phy_update(delta):
	if clock_wise:
		character.rotate(delta)
	else:
		character.rotate(-delta)
	
	if character.velocity.y > 0:
		character.velocity.y += player_data.INTENSE_GRAVITY * delta
	else:
		character.velocity.y += player_data.GRAVITY * delta
	
	if character.position.y > 300:
		parent.exit()

func exit():
	character.queue_free()


func _init() -> void:
	id = "dead"
