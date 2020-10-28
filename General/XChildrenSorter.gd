class_name XChildrenSorter
extends Node2D

signal updated_possible_positions

export var x_unit := 16
export var columns_number := 4

var possible_positions := []
var sort := true


func _process(delta: float) -> void:
	if sort:
		update_possible_positions()
		yield(self, "updated_possible_positions")
		sort_children()
		sort = false

	
func update_possible_positions() -> void:
	var current_position := global_position
	var i = 0
	while i < columns_number:
		current_position.x += x_unit
		possible_positions.append(current_position)
		i += 1

	emit_signal("updated_possible_positions")


func sort_children() -> void:
	for i in get_children().size():
		var child = get_child(i)
		child.global_position = possible_positions[i]


func do_sort() -> void:
	sort = true


func is_children_sorted() -> bool:
	for i in get_children().size():
		var child = get_child(i)
		if child.global_position != possible_positions[i]:
			return false
			
	return true

