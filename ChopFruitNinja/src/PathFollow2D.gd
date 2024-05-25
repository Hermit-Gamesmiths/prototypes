
extends Node2D
@export var right_stick := false
@export var main_node := false
var input_vector
var chopping := false

func _ready():
	GameEvents.sliced_meat.connect(_on_sliced_meat)
	GameEvents.chop_finished.connect(_on_chop_fin)
	set_process(true)
	if not right_stick:
		rotation_degrees = 180
	

var move_speed := 0.01

# Distance from the center
var radius := 150.0
# Center position of the circle
var center := Vector2(0, 0) # Adjust to your desired center position

func _process(delta):
	var input_vector = Vector2()

	if right_stick:
		input_vector.x = Input.get_action_strength("right_stick_right") - Input.get_action_strength("right_stick_left")
		input_vector.y = Input.get_action_strength("right_stick_down") - Input.get_action_strength("right_stick_up")
	else:
		input_vector.x = Input.get_action_strength("left_stick_right") - Input.get_action_strength("left_stick_left")
		input_vector.y = Input.get_action_strength("left_stick_down") - Input.get_action_strength("left_stick_up")
		

	if input_vector.length() > 0 and not chopping:
		input_vector = input_vector.normalized()
		var angle = input_vector.angle()
		rotation = angle



func _on_sliced_meat():
	chopping = true



func _on_chop_fin():
	await get_tree().create_timer(1.0).timeout
	chopping = false
