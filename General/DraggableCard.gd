extends Area2D

var is_dragged := false


func _ready() -> void:
	connect("input_event", self, "_on_input_event")


func _process(delta: float) -> void:
	if is_dragged:
		global_position = get_global_mouse_position()


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("drag"):
		is_dragged = true
	elif event.is_action_released("drag"):
		is_dragged = false
