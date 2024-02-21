class_name CoyoteTimeState
extends PlayerState



func enter(args = {}):
	super.enter(args)
	get_tree().create_timer(player_data.COYOTE_TIME).timeout.connect(_on_timeout)


func phy_update(_delta):
	if Input.is_action_just_pressed("jump"):
		parent.set_state("jump")


func _on_timeout():
	parent.set_state("fall")

func _init() -> void:
	id = "coyote"
