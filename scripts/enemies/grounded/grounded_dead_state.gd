@tool
class_name GroundedDeadState
extends StateAnimation

var dead_jump_force = -150
var clock_wise = false

func enter(args = {}):
	super.enter(args)
	Global.camera_shaked.emit()
	character.disable_checks()
	character.velocity = Vector2.ZERO
	var direction = args["direction"] as Vector2
	if direction.x > 0:
		clock_wise = true
	character.velocity.x = direction.x * 100
	if direction.y <= 0:
		character.velocity.y = dead_jump_force


func phy_update(delta):
	if clock_wise:
		character.rotate(delta)
	else:
		character.rotate(-delta)
	
	character.velocity.y += 1200 * delta
	
	if character.position.y > 300:
		character.queue_free()


func _init():
	id = "dead"
