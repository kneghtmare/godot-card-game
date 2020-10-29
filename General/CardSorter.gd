class_name CardSorter
extends Node2D

export var unit: Vector2 = Vector2(16,0)

var card_positions: Array = []

onready var children_array: Array = get_children()


func _init() -> void:
	Globals.cardSorter = self


func _ready() -> void:
	sort()


func _process(delta: float) -> void:
	if not is_sorted():
		sort()
	
	
func sort() -> void:
	var current_position := global_position
	var i = 0
	while i < get_child_count():
		current_position += unit
		get_child(i).global_position = current_position
		card_positions.append(current_position)
		i += 1
	

func is_sorted() -> bool:
	for i in get_children().size():
		var child = get_child(i)
		if child.global_position != card_positions[i]:
			return false
			
	return true

