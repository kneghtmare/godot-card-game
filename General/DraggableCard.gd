class_name DraggableCard
extends Area2D

export (String, FILE) var card_scene_path: String
export var normal_scale: Vector2
export var zoomed_scale: Vector2

var play_area_entered: bool = false
var is_dragged: bool = false
var card : Card = Card.new()

onready var currentScene: Node = get_tree().current_scene
onready var zoomTween: Tween = $ZoomTween


func _ready() -> void:
	card.scene = load(card_scene_path)
	# signal connections
	connect("input_event", self, "_on_input_event")
	connect("area_entered", self, "_on_area_entered")
	connect("area_exited", self, "_on_area_exited")	
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")
	

func _process(delta: float) -> void:
	if is_dragged:
		global_position = get_global_mouse_position()
	else: # if the player stops dragging and the we are also in play area
		if play_area_entered:	
			play()
			
		if not get_parent() is CardSorter:
			Globals.reparent(self, Globals.cardSorter)
		
		
	
func play():
	var instance = card.scene.instance()
	instance.global_position = global_position
	currentScene.add_child(instance)
	queue_free()


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		#sets dragging to true
		if event.pressed and not Globals.is_dragging_something:
			is_dragged = true
			Globals.is_dragging_something = true
			#reparents to current scene
			Globals.reparent(self, currentScene)
		else:
			is_dragged = false
			Globals.is_dragging_something = false
			#if we're not dragging this, and not play area entered
			#if play_area_entered was true, play() would be called


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("PlayArea"):
		play_area_entered = true		


func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("PlayArea"):
		play_area_entered = false		


func _on_mouse_entered() -> void:
	zoomTween.interpolate_property(self, "scale", scale, zoomed_scale,
		0.5, Tween.TRANS_QUINT)
	zoomTween.start()


func _on_mouse_exited() -> void:
	zoomTween.interpolate_property(self, "scale", scale, normal_scale,
		0.5, Tween.TRANS_QUINT)
	zoomTween.start()
