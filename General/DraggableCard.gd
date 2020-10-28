extends Area2D


enum States {
	SUBSTITUTE,
	PLAYING
}


export (String, FILE) var card_scene_path: String

var state: int = States.SUBSTITUTE
var play_area_entered := false
var is_dragged := false
var card := Card.new()


func _ready() -> void:
	card.scene = load(card_scene_path)
	#signal connections
	connect("input_event", self, "_on_input_event")
	connect("area_entered", self, "_on_area_entered")
	connect("area_exited", self, "_on_area_exited")	


func _process(delta: float) -> void:
	state_process()
	

func state_process() -> void:
	match state:
		States.SUBSTITUTE:
			if is_dragged:
				global_position = get_global_mouse_position()
			
			if play_area_entered:
				if not is_dragged:
					set_state(States.PLAYING)
	
		States.PLAYING:
			pass	
	
	
#SIGNALS
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			is_dragged = true
		else:
			is_dragged = false


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("PlayArea"):
		play_area_entered = true		


func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("PlayArea"):
		play_area_entered = false		


#SETTTERS AND GETTERS
func set_state(new_state: int) -> void:
	if state != new_state:
		state = new_state
