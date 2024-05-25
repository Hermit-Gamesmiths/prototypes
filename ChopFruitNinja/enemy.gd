extends StaticBody2D


var value: int
var health: int
var color_choice
var already_dead := false
func _ready():
	GameEvents.chop_finished.connect(_on_chop_finished)
	# Generate a random number between 0 and 2 to represent the color choice
	var random_color = randi() % 3

	# Assign the color based on the random number
	match random_color:
		0:
			color_choice = GameEvents.ColorType.RED
		1:
			color_choice = GameEvents.ColorType.GREEN
		2:
			color_choice = GameEvents.ColorType.GREY

	match color_choice:
		GameEvents.ColorType.RED:
			$Sprite2D.modulate = Color(1, 0, 0)  # Red
		GameEvents.ColorType.GREEN:
			$Sprite2D.modulate = Color(0, 1, 0)  # Green
		GameEvents.ColorType.GREY:
			$Sprite2D.modulate = Color(0.5, 0.5, 0.5)  # Grey
		GameEvents.ColorType.PURPLE:
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
	if area.is_in_group("hitbox"):
		$AnimationPlayer.play("hurt")
		health -= 1
		if health <= 0:
			GameEvents.enemy_died.emit(color_choice)
			already_dead = true
			

func _on_chop_finished():
	if already_dead:
		queue_free()
