extends Area2D

@export var size := 5.0
var value:= 5.0
var max_val = 50.0
var min_val = 10.0
var picked_up := false

func _ready():
	$CollisionShape2D.shape.radius = size


func _process(delta):
	value = max(max_val - size, min_val)
	if $CollisionShape2D.shape.radius != size:
		$CollisionShape2D.shape.radius = size
		$dotted_line.size.x = size*2
		$dotted_line.size.y = size*2
		var pos := Vector2(-size, -size)
		$dotted_line.position = pos
		
		var line_max := 0.1
		
		$dotted_line.material.set_shader_parameter("thickness", (60.0-size)/550)
	
		var freq = size/3
		freq = max(freq, 4)
		$dotted_line.material.set_shader_parameter("frequency", int(freq))
		#queue_redraw()
	
	if picked_up:
		size += 30*delta
		

#func _draw():
	#var radius = $CollisionShape2D.shape.radius
	#draw_arc(Vector2.ZERO, radius, 0, TAU, radius, Color.WHITE)


func on_pickup():
	picked_up = true
	await get_tree().create_timer(0.5).timeout
	queue_free()

