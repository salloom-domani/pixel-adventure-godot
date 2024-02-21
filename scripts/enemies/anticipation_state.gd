@tool
extends StateAnimation


func enter(args = {}):
	super.enter(args)
	animated_sprite.animation_finished.connect(_on_animation_finish)
	character.velocity.x = 100 * character.direction



func _on_animation_finish():
	parent.parent.set_state("in_air/jump")
	

func exit():
	super.exit()
	animated_sprite.animation_finished.disconnect(_on_animation_finish)
