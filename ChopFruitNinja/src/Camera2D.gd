extends Camera2D



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameEvents.paused:
		zoom = lerp(zoom, Vector2(4.0, 4.0), 0.2)
		offset.x = lerp(offset.x, 100.0, 0.2)
		rotation_degrees = lerp(rotation_degrees, -17.0, 0.5)
	else:
		zoom = lerp(zoom, Vector2(2.0, 2.0), 0.2)
		offset.x = lerp(offset.x, 0.0, 0.2)
		rotation_degrees = lerp(rotation_degrees, 0.0, 0.5)
