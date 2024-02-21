extends State


# Happens once the state is entered
func enter(args = {}):
	super.enter(args)

# Happens every frame while the state is active
func update(delta):
	super.update(delta)

# Happens every phyiscs frame while  the state is active
func phy_update(delta):
	super.phy_update(delta)

# Happens once the state is exited
func exit():
	super.exit()
