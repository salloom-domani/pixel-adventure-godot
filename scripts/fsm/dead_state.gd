@tool
class_name DeadState
extends PlayerStateAnimation


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
		character.queue_free()
		#parent.exit()

#func exit():
	#super.exit()
	#character.queue_free()


func _init() -> void:
	id = "dead"
