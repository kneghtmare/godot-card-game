class_name CardSorter
extends Node2D

signal updated_possible_positions

export var unit := Vector2(16,0)

var possible_positions := []
var sort := true

func _init() -> void:
	Globals.cardSorter = self
	

func _process(delta: float) -> void:
	#sorts if sort is true
	if sort:
		#sort code
		update_possible_positions()
		yield(self, "updated_possible_positions")
		sort_children()
		sort = false

	if not Globals.is_dragging_something and not is_sorted():
		do_sort()
	
	
func update_possible_positions() -> void:
	var current_position := global_position
	var i = 0
	while i < get_child_count():
		current_position += unit
		possible_positions.append(current_position)
		i += 1

	emit_signal("updated_possible_positions")


func sort_children() -> void:
	for i in get_children().size():
		var child = get_child(i)
		child.global_position = possible_positions[i]


func do_sort() -> void:
	sort = true


func is_sorted() -> bool:
	for i in get_children().size():
		var child = get_child(i)
		if child.global_position != possible_positions[i]:
			return false
			
	return true

