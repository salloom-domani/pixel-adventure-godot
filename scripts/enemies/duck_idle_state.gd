@tool
extends StateAnimation

@onready var vision = %Vision

func enter(args = {}):
	super.enter(args)
	animated_sprite.animation_finished.connect(_on_animation_finish)


func phy_update(delta):
	if vision.can_move():
		character.flip()
		character.direction *= -1

func _on_animation_finish():
	parent.set_state("anticipate")
	

func exit():
	super.exit()
	animated_sprite.animation_finished.disconnect(_on_animation_finish)
