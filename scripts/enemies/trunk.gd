class_name Trunk
extends Mob

@onready var player_detector: Area2D = %PlayerDetector

func disable_checks():
	super.disable_checks()
	for connection in player_detector.body_entered.get_connections():
		player_detector.body_entered.disconnect(connection["callable"])
	for connection in player_detector.body_exited.get_connections():
		player_detector.body_exited.disconnect(connection["callable"])
