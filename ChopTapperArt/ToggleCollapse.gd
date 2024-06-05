extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_CheckBox_toggled(button_pressed: bool) -> void:
	collapse_all_nodes(get_tree().get_root(), button_pressed)

func collapse_all_nodes(node: Node, collapse: bool) -> void:
	if node is Tree:
		node.set_collapsed(collapse)
	
	for child in node.get_children():
		collapse_all_nodes(child, collapse)
