class_name Radish
extends Mob

@onready var leafs_pos = $LeafsPos

@export var leafs_scene: PackedScene

func die(hit_dir: Vector2):
	Global.camera_shaked.emit()
	match state_machine.current_state.id:
		"zap":
			explode_leafs()
			state_machine.set_state("fall")
		_:
			state_machine.set_state("dead", {"direction": hit_dir * -1})


func explode_leafs():
	var leafs = leafs_scene.instantiate()
	leafs.position = leafs_pos.global_position
	add_sibling.call_deferred(leafs)
	leafs.explode(150)
