@tool
class_name FallState
extends PlayerStateAnimation


#func phy_update(delta):
	#var collision_count = character.get_slide_collision_count()
	#for i in collision_count:
		#var collision = character.get_slide_collision(i)
		#if collision and collision.get_collider() is Box:
			#collide_with_box(collision.get_collider())
#
#
#func collide_with_box(box: Box):
	#if box.is_directly_on_top_or_down(character.position, character.collision_shape.shape.extents.x):
		#box.hit()
		#if character.position.y < box.position.y:
			#parent.set_state("jump")
#

func _init() -> void:
	id = "fall"
