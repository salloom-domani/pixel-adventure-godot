class_name TargetedStateMachine
extends MobStateMachine

var target = null
var changing_direction = false
var timer: Timer

func _ready() -> void:
	super.start()
	character.target_died.connect(lost_player)

func lost_player():
	target = null

func follow_target_direction():
	if not target: return
	var new_direction = sign(target.position.x - character.position.x)
	if character.direction != new_direction and not changing_direction:
		changing_direction = true
		await get_tree().create_timer(0.2).timeout
		character.flip_for_direction(new_direction)
		changing_direction = false

func _on_player_detector_body_entered(body):
	if body.is_in_group("player"):
		target = body
		if timer:
			del_default_timer()

func _on_player_detector_body_exited(body):
	if body.is_in_group("player"):
		timer = add_default_timer(3, lost_player)
