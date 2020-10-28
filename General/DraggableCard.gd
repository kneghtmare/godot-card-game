class_name DraggableCard
extends Area2D

export (String, FILE) var card_scene_path: String

var play_area_entered := false
var is_dragged := false
var card := Card.new()

onready var currentScene: Node = get_tree().current_scene


func _ready() -> void:
	card.scene = load(card_scene_path)
	# signal connections
	connect("input_event", self, "_on_input_event")
	connect("area_entered", self, "_on_area_entered")
	connect("area_exited", self, "_on_area_exited")	
	

func _process(delta: float) -> void:
	if is_dragged:
		global_position = get_global_mouse_position()
	else: # if the player stops dragging and the we are also in play area
		if play_area_entered:	
			play()
	
	
func play():
	var instance = card.scene.instance()
	instance.global_position = global_position
	currentScene.add_child(instance)
	queue_free()


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

