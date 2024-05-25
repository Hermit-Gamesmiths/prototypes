#extends Node2D
#
#var color_options = ["Grey", "Red", "Green"]
#var color_string
#
#
#var color_value_dict = {}
#@onready var detection_area := $FeedArea
#@onready var sprite := $Sprite2D
#@onready var sprite2 := $Sprite2D2
#var player_in_area := false
#
#@onready var label := $Label
#var value := 0
#
#func _ready():
	#detection_area.body_entered.connect(_on_body_ent)
	#detection_area.body_exited.connect(_on_body_ext)
	#randomize()
	#color_string = color_options[randi() % color_options.size()]
	#value = randi() % 5 + 1
	#color_value_dict = {"color": color_string, "value": value}
	#GameEvents.requests.append(color_value_dict)
	#set_sprite_modulate(color_string)
	#set_star_rating(value)
#
#func _process(delta):
	#if Input.is_action_just_pressed("attack") and player_in_area:
		#check_for_matching_item()
#
#func _on_body_ent(body):
	#if body.is_in_group("player"):
		#player_in_area = true
#
#
#
#func _on_body_ext(body):
	#if body.is_in_group("player"):
		#player_in_area = false
#
#
#
#func set_sprite_modulate(color_option):
	#match color_option:
		#"Grey":
			#sprite.modulate = Color(0.5, 0.5, 0.5)  # Set modulate to grey
		#"Red":
			#sprite.modulate = Color(1, 0, 0)  # Set modulate to red
		#"Green":
			#sprite.modulate = Color(0, 1, 0)  # Set modulate to green
		#_:
			#sprite.modulate = Color(1, 1, 1)  # Set modulate to white (default) for any other color option
#
#
#
#
#func set_star_rating(rating: int) -> void:
	#value = rating
	#var star_emoji := "🌟"
	#var star_rating := ""
	#
	#for _i in range(value):
		#star_rating += star_emoji
	#
	#label.text = star_rating
#
#
#func check_for_matching_item():
	#for i in range(GameEvents.inventory.size()):
		#if GameEvents.inventory[i] == color_value_dict:
			#GameEvents.inventory.remove_at(i)
			#GameEvents.requests.erase(color_value_dict)
			#GameEvents.scored.emit()
			#generate_new_request()
			#return
#
	#for i in range(GameEvents.inventory.size()):
		#if GameEvents.inventory[i]["color"] == "Purple":
			#GameEvents.inventory.remove_at(i)
			#GameEvents.requests.erase(color_value_dict)
			#GameEvents.scored.emit()
			#generate_new_request()
			#return
#
#func generate_new_request():
	#randomize()
	#color_string = color_options[randi() % color_options.size()]
	#value = randi() % 5 + 1
	#color_value_dict = {"color": color_string, "value": value}
	#GameEvents.requests.append(color_value_dict)
	#set_sprite_modulate(color_string)
	#set_star_rating(value)
#
#
extends Node2D

var color_options = ["Grey", "Red", "Green"]
var color_string

var color_value_dict = {}
@onready var detection_area := $FeedArea
@onready var sprite := $Sprite2D
@onready var sprite2 := $Sprite2D2
var player_in_area := false

@onready var label := $Label
var value := 0

func _ready():
	sprite.frame = randf_range(0, sprite.hframes-1)
	sprite2.frame = randf_range(0, sprite2.hframes-1)
	detection_area.body_entered.connect(_on_body_ent)
	detection_area.body_exited.connect(_on_body_ext)
	randomize()
	color_string = color_options[randi() % color_options.size()]
	value = randi() % 5 + 1
	color_value_dict = {"color": color_string, "value": value}
	GameEvents.requests.append(color_value_dict)
	set_sprite_modulate(color_string)
	set_star_rating(value)
	sprite.position = Vector2(0, 50) 
	sprite2.position = Vector2(0, -20) 
	var temp_sprite = sprite
	sprite = sprite2
	sprite2 = temp_sprite
	

func _process(delta):
	if Input.is_action_just_pressed("attack") and player_in_area:
		check_for_matching_item()

func _on_body_ent(body):
	if body.is_in_group("player"):
		player_in_area = true

func _on_body_ext(body):
	if body.is_in_group("player"):
		player_in_area = false

func set_sprite_modulate(color_option):
	match color_option:
		"Grey":
			sprite2.modulate = Color(0.5, 0.5, 0.5)  # Set modulate to grey
			$Label.modulate = Color(0.5, 0.5, 0.5)  # Set modulate to grey
		"Red":
			sprite2.modulate = Color(1, 0, 0)  # Set modulate to red
			$Label.modulate = Color(1, 0, 0)
		"Green":
			sprite2.modulate = Color(0, 1, 0)  # Set modulate to green
			$Label.modulate = Color(0, 1, 0) 
		_:
			sprite2.modulate = Color(1, 1, 1)  # Set modulate to white (default) for any other color option
	
	

func set_star_rating(rating: int) -> void:
	value = rating
	var star_emoji := "✮"
	var star_rating := ""
	
	for _i in range(value):
		star_rating += star_emoji
	
	label.text = star_rating

func check_for_matching_item():
	for i in range(GameEvents.inventory.size()):
		if GameEvents.inventory[i] == color_value_dict:
			GameEvents.inventory.remove_at(i)
			GameEvents.requests.erase(color_value_dict)
			GameEvents.scored.emit()
			generate_new_request()
			return

	for i in range(GameEvents.inventory.size()):
		if GameEvents.inventory[i]["color"] == "Purple":
			GameEvents.inventory.remove_at(i)
			GameEvents.requests.erase(color_value_dict)
			GameEvents.scored.emit()
			generate_new_request()
			return

func generate_new_request():
	randomize()
	color_string = color_options[randi() % color_options.size()]
	value = randi() % 5 + 1
	color_value_dict = {"color": color_string, "value": value}
	GameEvents.requests.append(color_value_dict)
	
	# Set the color of the non-active sprite
	set_sprite_modulate(color_string)
	
	# Swap the sprites and perform the sliding animation
	swap_sprites()
	
	set_star_rating(value)

func swap_sprites():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_IN_OUT)
	
	
	var move_amy := 80
	# Move the active sprite down
	tween.tween_property(sprite2, "position", Vector2(sprite2.position.x, sprite2.position.y - move_amy), 0.5)
	
	# Move the inactive sprite up
	tween.parallel().tween_property(sprite, "position", Vector2(sprite.position.x, sprite.position.y + move_amy), 0.5)
	
	await get_tree().create_timer(0.5).timeout
	sprite.frame = randf_range(0, sprite.hframes-1)
	var temp_sprite = sprite
	sprite = sprite2
	sprite2 = temp_sprite
	#
	## Reset the sprite positions
	#sprite.position = Vector2(0, 0)
	#sprite2.position = Vector2(0, -30)

