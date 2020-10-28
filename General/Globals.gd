extends Node

var is_dragging_something := false 
var cardSorter: CardSorter

func _ready() -> void:
	OS.center_window()
