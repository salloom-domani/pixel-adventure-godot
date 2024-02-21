extends State

var speed = 0

# Happens once the state is entered
func enter(args = {}):
	super.enter(args)
	character.velocity.y = 0
	speed = character.velocity.x


func phy_update(delta):
	super.phy_update(delta)
	if not character.is_on_floor():
		parent.set_state("in_air/fall")
	character.velocity.x -= character.velocity.x * 0.1



func _init():
	id = "grounded"
