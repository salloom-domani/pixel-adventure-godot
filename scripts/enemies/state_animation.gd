@tool
class_name StateAnimation
extends State

@export var animated_sprite: AnimatedSprite2D: set = set_animated_sprite
@export var state_id: String


var animation: StringName
var animations: PackedStringArray


func _ready():
	if state_id:
		id = state_id

func set_animated_sprite(val):
	animated_sprite = val
	if animated_sprite:
		animations.append_array(animated_sprite.sprite_frames.get_animation_names())
	else:
		animations.clear()
	notify_property_list_changed()


func _get_property_list():
	var property_usage = PROPERTY_USAGE_NO_EDITOR
	
	if animated_sprite:
		property_usage = PROPERTY_USAGE_DEFAULT
	
	var animations_string = ",".join(animations) if animations else "[]"
	var properties = []
	properties.append({
		"name": "animation",
		"type": TYPE_STRING_NAME,
		"usage": property_usage,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": animations_string
	})
	return properties


func enter(args = {}):
	super.enter(args)
	animated_sprite.play(animation)
