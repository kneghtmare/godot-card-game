extends Node

var is_dragging_something: bool = false 
var cardSorter: CardSorter


func _ready() -> void:
	OS.center_window()
	
	
func reparent(child: Node2D, new_parent: Node2D) -> void:
	var old_parent = child.get_parent()
	var old_position = child.global_position
	old_parent.remove_child(child)
	new_parent.add_child(child)
	child.global_position = old_position		
	
