class_name ZappingState
extends State

@export var x_speed = 50
@export var y_speed = 50

@export var x_timer = 3
@export var y_timer = 2

@export var should_flip = false


var tween_x: Tween
var tween_y: Tween

func enter(args = {}):
	super.enter(args)
	character.velocity = Vector2(-x_speed, -y_speed)
	tween_x = create_tween().set_trans(Tween.TRANS_SINE).set_loops()
	tween_y = create_tween().set_trans(Tween.TRANS_SINE).set_loops()
	tween_x.tween_property(character, "velocity:x", x_speed, x_timer)
	tween_x.tween_property(character, "velocity:x", -x_speed, x_timer)
	tween_y.tween_property(character, "velocity:y", y_speed, y_timer)
	tween_y.tween_property(character, "velocity:y", -y_speed, y_timer)

func phy_update(delta):
	if should_flip:
		character.flip_for_direction(sign(character.velocity.x))


func exit():
	super.exit()
	tween_x.kill()
	tween_y.kill()

func _init():
	id = "zap"


