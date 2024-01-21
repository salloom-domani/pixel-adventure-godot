@tool
extends Sprite2D

@export var textures: Array[Texture2D] = []
var current_texture: String: set = set_current_texture


func texture_with_name(array: Array[Texture2D], tex_name: String):
	for i in array.size():
		if array[i].get_path().contains(tex_name):
			return i
	return -1


func set_current_texture(val):
	current_texture = val
	var texture_idx = texture_with_name(textures, val)
	texture = textures[texture_idx]


func map_texture_to_name(tex: Texture2D):
	return tex.get_path().get_file().replace(".png", "")

func _get_property_list():
	var properties = []
	if textures.size() > 0:
		properties.append({
			"name": "current_texture",
			"type": TYPE_STRING,
			"hint": PROPERTY_HINT_ENUM,
			"hint_string": ",".join(textures.map(map_texture_to_name))
		})
	return properties

func _ready():
	texture = textures.pick_random()

