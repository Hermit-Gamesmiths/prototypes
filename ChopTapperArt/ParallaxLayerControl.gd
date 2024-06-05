@tool
extends ParallaxBackground

@export var motion_scale_decrement := 0.1

func _ready() -> void:
	if not Engine.is_editor_hint():
		return

	_update_motion_scales()

func _process(delta: float) -> void:
	if not Engine.is_editor_hint():
		return

	_update_motion_scales()

func _update_motion_scales() -> void:
	var layers = get_children()
	layers.reverse()

	var current_scale = 1.0 - motion_scale_decrement

	for layer in layers:
		if layer is ParallaxLayer:
			layer.motion_scale = Vector2(current_scale, current_scale)
			current_scale -= motion_scale_decrement

