extends State

@onready var vision = %Vision

@export var speed = 30


func phy_update(delta):
	super.phy_update(delta)
	if not vision.can_move():
		character.flip()
		character.direction *= -1
	
	character.velocity.x = speed * character.direction

func _init():
	id = "move"
