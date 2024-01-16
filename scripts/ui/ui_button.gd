extends Button


@export var hover_duration = 0.2
@export var click_duration = 0.1

var hover_timer = 0.0
var press_timer = 0.0
var hovered = false
var clicked = false

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	pressed.connect(_on_pressed)


func _process(delta: float) -> void:
	if hovered:
		hover_timer += delta
	
	if hovered and hover_timer > hover_duration:
		position.y += 1
		hover_timer = 0
		hovered = false
		
	if clicked:
		press_timer += delta
	
	if clicked and press_timer > click_duration:
		position.y -= 2
		press_timer = 0
		clicked = false

func _on_pressed() -> void:
	if not clicked:
		position.y += 2
	clicked = true

func _on_mouse_entered() -> void:
	if not hovered:
		position.y -= 1
	hovered = true
