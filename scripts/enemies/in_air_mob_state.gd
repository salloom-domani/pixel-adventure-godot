extends State

@export var jump_velocity = Vector2(100, 300)
@export var gravity = 980


@onready var jump_particles = %JumpParticles
@onready var land_particles = %LandParticles


func phy_update(delta):
	character.velocity.y += gravity * delta
	
	if character.is_on_floor():
		parent.set_state("grounded/idle")
	
	if character.velocity.y > 0:
		character.velocity.x = jump_velocity.x * character.direction
		set_state("fall")
	
	super.phy_update(delta)
	


func _on_jump_state_state_entered():
	jump_particles.restart()
	character.velocity.x = jump_velocity.x * character.direction
	character.velocity.y = -jump_velocity.y

func exit():
	super.exit()
	land_particles.restart()

func _init():
	id = "in_air"
