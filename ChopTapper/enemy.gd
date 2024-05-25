extends StaticBody2D

enum ColorType { RED, GREEN, GREY, PURPLE }

var value: int
var health: int
var color_choice

func _ready():

	# Generate a random number between 0 and 2 to represent the color choice
	var random_color = randi() % 3

	# Assign the color based on the random number
	match random_color:
		0:
			color_choice = ColorType.RED
		1:
			color_choice = ColorType.GREEN
		2:
			color_choice = ColorType.GREY
	if GameEvents.purple_counter <= 0:
		color_choice = ColorType.PURPLE
		GameEvents.purple_counter = GameEvents.amount_until_purple
	else:
		GameEvents.purple_counter -= 1

	match color_choice:
		ColorType.RED:
			$Sprite2D.modulate = Color(1, 0, 0)  # Red
		ColorType.GREEN:
			$Sprite2D.modulate = Color(0, 1, 0)  # Green
		ColorType.GREY:
			$Sprite2D.modulate = Color(0.5, 0.5, 0.5)  # Grey
		ColorType.PURPLE:
			$Sprite2D.modulate = Color(0.75, 0, 1)  # Grey

	value = randi_range(5, 10)
	if value <= 6:
		health = 2
		$Sprite2D.frame = 2
	elif value <= 8:
		health = 3
		$Sprite2D.frame = 1
	else:
		health = 4
		$Sprite2D.frame = 0
	$Hurtbox.area_entered.connect(_on_area_entered)

func _process(delta):
	pass

func _on_area_entered(area):
	if area is Hitbox:
		$AnimationPlayer.play("hurt")
		health -= 1
		if health <= 0:
			var drop_scene = load("res://drop.tscn").instantiate()
			add_sibling(drop_scene)
			drop_scene.position = position
			var random_number = randi() % 3
			match color_choice:
				ColorType.RED:
					match random_number:
						0:
							drop_scene.setSpriteColors(GameEvents.ColorCombo.RED_RED)
						1:
							drop_scene.setSpriteColors(GameEvents.ColorCombo.RED_RED)
						2:
							drop_scene.setSpriteColors(GameEvents.ColorCombo.RED_RED)
				ColorType.GREEN:
					match random_number:
						0:
							drop_scene.setSpriteColors(GameEvents.ColorCombo.GREEN_GREEN)
						1:
							drop_scene.setSpriteColors(GameEvents.ColorCombo.GREEN_GREEN)
						2:
							drop_scene.setSpriteColors(GameEvents.ColorCombo.GREEN_GREEN)

				ColorType.GREY:
					match random_number:
						0:
							drop_scene.setSpriteColors(GameEvents.ColorCombo.GREY_GREY)
						1:
							drop_scene.setSpriteColors(GameEvents.ColorCombo.GREY_GREY)
						2:
							drop_scene.setSpriteColors(GameEvents.ColorCombo.GREY_GREY)
				ColorType.PURPLE:
					drop_scene.setSpriteColors(GameEvents.ColorCombo.PURPLE_PURPLE)
					
					
			queue_free()
