extends Line2D

@onready var point_a = $"../Handle1/Node2D"
@onready var point_b = $"../handle2/Node2D"
@onready var path2d = $Path2D
var chopper_node := preload("res://chopper.tscn")
var nodey
func _ready():
	update_points()
	GameEvents.sliced_meat.connect(_on_sliced_meat)

func _process(delta):
	update_points()
	$Path2D/PathFollow2D.progress_ratio -= (delta * 2)
	if $Path2D/PathFollow2D.progress_ratio <= 0.1:
		delete_all_children()


func delete_all_children():
	for child in $Path2D/PathFollow2D.get_children():
		child.queue_free()


func update_points():
	var global_position_a = point_a.global_position
	var global_position_b = point_b.global_position

	var local_position_a = to_local(global_position_a)
	var local_position_b = to_local(global_position_b)
	
	points = [local_position_a, local_position_b]
	update_path2d(local_position_a, local_position_b)

func update_path2d(start_point, end_point):
	var curve = path2d.curve
	curve.clear_points()
	curve.add_point(start_point)
	curve.add_point(end_point)
	path2d.curve = curve
	


func _on_sliced_meat():
	nodey = chopper_node.instantiate()
	$Path2D/PathFollow2D.add_child(nodey)
	nodey.position = position
	$Path2D/PathFollow2D.progress_ratio = 1.0
