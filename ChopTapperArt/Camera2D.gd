extends Camera2D

@export var parallax_background: NodePath

func _process(delta: float) -> void:
	if parallax_background:
		var parallax_node = get_node(parallax_background)
		if parallax_node is ParallaxBackground:
			parallax_node.scroll_offset = -global_position
