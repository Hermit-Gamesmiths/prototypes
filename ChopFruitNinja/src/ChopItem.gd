extends Node2D

var cut_area_node := preload("res://cut_area.tscn")
var bone_node := preload("res://bone.tscn")
var purple_bonus_node := preload("res://purple_bonus.tscn")
var radius = 4  
var full_value := 0.0
var sliced := false
var scored_value := 0
var my_color := GameEvents.ColorType.RED
var my_value := 0
@onready var progress_bar := $ProgressBar
var countdown_max_time := 5.0 
var countdown_time := countdown_max_time
var timer_running := true

var count := 0.0

func _ready():
	reset()
	GameEvents.slice_scored.connect(_on_slice_score)
	GameEvents.enemy_died.connect(_on_enemy_death)
	GameEvents.chop_finished.connect(_on_chop_finished)
	$ProgressBar.max_value = countdown_max_time
	$ProgressBar.value = countdown_max_time

	

func reset():
	timer_running = true
	countdown_time = countdown_max_time
	$Sprite2D.modulate = Color(1, 1, 1)  # Reset to default color (white)
	$score.text = ""
	full_value = 0.0
	sliced = false
	scored_value = 0
	my_color = GameEvents.ColorType.RED
	my_value = 0
	
	 #Remove existing cut area nodes and bones
	for child in get_children():
		if child.is_in_group("cut_area") or child.is_in_group("bone"):
			child.queue_free()
	
	# Add new cut area nodes and bones
	var node_position = Vector2(0, 0)  # Get the position of the current node
	for x in range(-radius, radius + 1):
		for y in range(-radius, radius + 1):
			if Vector2(x, y).length() <= radius:
				if randi() % 12 == 0:
					add_cut_area_node(node_position + Vector2(x * 16, y * 16))
	if randi() % 3 == 0:
		add_bone(node_position)
	if GameEvents.purple_counter <= 0:
		add_purple_bonus(node_position)
		GameEvents.purple_counter = GameEvents.purple_counter_amount
	else:
		GameEvents.purple_counter -= 1


func add_cut_area_node(position):
	var instance = cut_area_node.instantiate()
	instance.position = position
	add_child(instance)
	instance.size = randf_range(5.0, 50.0)
	full_value += max(instance.max_val - instance.size, instance.min_val)


func _process(delta):
	if visible and timer_running:
		countdown_time -= delta
		$ProgressBar.value = countdown_time
		if countdown_time <= 0 and not sliced:
			GameEvents.chop_finished.emit()
			
	
	if Input.is_action_just_pressed("slice"):
		GameEvents.sliced_meat.emit()
		sliced = true
	if sliced:
		if scored_value == 0:
			$stars.text = "❌"
			my_value = 0
			$stars.visible = true
		elif scored_value == 1:
			$stars.text = "🌟"
			my_value = 1
			$stars.visible = true
		elif scored_value == 2:
			$stars.text = "🌟🌟"
			my_value = 2
			$stars.visible = true
		elif scored_value == 3:
			$stars.text = "🌟🌟🌟"
			my_value = 3
			$stars.visible = true
		elif scored_value == 4:
			$stars.text = "🌟🌟🌟🌟"
			my_value = 4
			$stars.visible = true
		else:
			$stars.text = "🌟🌟🌟🌟🌟"
			my_value = 5
			$stars.visible = true

func add_purple_bonus(center_position: Vector2):
	var purple_bonus_instance = purple_bonus_node.instantiate()
	var angle = randf_range(0, 2 * PI)
	var distance = randf_range(0, radius)
	var random_position = center_position + Vector2(cos(angle), sin(angle)) * distance * 16
	purple_bonus_instance.position = random_position
	purple_bonus_instance.rotation = randf_range(0.0, 350.0)
	add_child(purple_bonus_instance)


func add_bone(center_position: Vector2):
	var bone_instance = bone_node.instantiate()
	var angle = randf_range(0, 2 * PI)
	var distance = randf_range(0, radius)
	var random_position = center_position + Vector2(cos(angle), sin(angle)) * distance * 16
	bone_instance.position = random_position
	bone_instance.rotation = randf_range(0.0, 350.0)
	add_child(bone_instance)

func _on_slice_score(score):
	scored_value += 1


func _on_enemy_death(color):
	reset()
	my_color = color
	match color:
		GameEvents.ColorType.RED:
			$Sprite2D.modulate = Color(1, 0, 0)  # Red
		GameEvents.ColorType.GREEN:
			$Sprite2D.modulate = Color(0, 1, 0)  # Green
		GameEvents.ColorType.GREY:
			$Sprite2D.modulate = Color(0.5, 0.5, 0.5)  # Grey
		GameEvents.ColorType.PURPLE:
			$Sprite2D.modulate = Color(0.75, 0, 1)  # Purple


func _on_chop_finished():
	timer_running = false
	GameEvents.add_item(my_color, my_value)
	await get_tree().create_timer(0.5).timeout
	reset()

