class_name BigCustomer
extends Area2D


enum ColorType { RED, GREEN, GREY }
var value: int
var health: int
var color_choice
var base_speed := 3
var speed := base_speed

var run_away := false
var run_away_mult := 20.0
var run_away_time := 30.0
var angry_run_time := 3

var food_preference := GameEvents.ColorCombo.RED_RED
var food_preference2 := GameEvents.ColorCombo.RED_RED
var eaten := false
var end_game := false
var skip_food := false

var frozen := false
var freeze_time := 8.0

var shake = false
var shake_time := 1.0

var stomach := 0

func _ready():
	
	GameEvents.freeze.connect(freeze_color)
	GameEvents.lose_game.connect(on_game_lose)
	GameEvents.win_game.connect(on_game_win)
	area_entered.connect(_on_area_entered)
	var random_color = randi() % 3
	match random_color:
		0:
			color_choice = ColorType.RED
			food_preference = GameEvents.ColorCombo.RED_RED
			food_preference2 = GameEvents.ColorCombo.SUPER_RED
		1:
			color_choice = ColorType.GREEN
			food_preference = GameEvents.ColorCombo.GREEN_GREEN
			food_preference2 = GameEvents.ColorCombo.SUPER_GREEN
		2:
			color_choice = ColorType.GREY
			food_preference = GameEvents.ColorCombo.GREY_GREY
			food_preference2 = GameEvents.ColorCombo.SUPER_GREY
	$Sprite2D.frame = randf_range(0, 4)
	reset_sprite_color()
	

func reset_sprite_color():
	match color_choice:
		ColorType.RED:
			$Sprite2D.modulate = Color(1, 0, 0)  # Red
			$Node2D.modulate = Color(1, 0, 0)  # Red
		ColorType.GREEN:
			$Sprite2D.modulate = Color(0, 1, 0)  # Green
			$Node2D.modulate = Color(0, 1, 0)  # Green
		ColorType.GREY:
			$Sprite2D.modulate = Color(0.5, 0.5, 0.5)  # Grey
			$Node2D.modulate = Color(0.5, 0.5, 0.5)  # Grey
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not run_away and not frozen:
		position.x += speed * delta
	elif run_away:
		position.x -= (speed * run_away_mult) * delta

		


func _on_area_entered(area):
	if area.is_in_group("food"):
		skip_food = false
		if area.food_color == GameEvents.ColorCombo.SUPER_RED \
			or area.food_color == GameEvents.ColorCombo.SUPER_GREEN \
			or area.food_color == GameEvents.ColorCombo.SUPER_GREY:
				if area.food_color != food_preference2:
					skip_food = true
		if not eaten and not skip_food:
			if area.food_color == food_preference or area.food_color == food_preference2 or area.food_color == GameEvents.ColorCombo.PURPLE_PURPLE  or area.food_color == GameEvents.ColorCombo.SUPER_PURPLE:
				if area.super_food > 0:
					area.super_food -= 1
				else:
					area.call_deferred("queue_free")

				stomach += 1
				if stomach >= 3:
					$face.frame = 1
					$face.visible = true
					run_away = true
					eaten = true
					await get_tree().create_timer(run_away_time).timeout
					$face.visible = false
					run_away = false
					eaten = false
				else:
					add_food_to_stomach()
			else:
				area.call_deferred("queue_free")
				$face.frame = 0
				$face.visible = true
				speed = base_speed * 5
				await get_tree().create_timer(angry_run_time).timeout
				$face.visible = false
				speed = base_speed
		
func add_food_to_stomach():

	for child in $Node2D.get_children():
		if child.frame == 0:
			child.frame = 1
			break
	
	
func pay_and_leave():
	if not end_game:
		var coinscene = load("res://coin.tscn").instantiate()
		add_sibling(coinscene)
		coinscene.position = position
		coinscene.emitting = true
		GameEvents.earned_money.emit()
	queue_free()


func on_game_win():
	run_away = true
	eaten = true
	end_game = true


func on_game_lose():
	$face.frame = 0
	$face.visible = true
	speed = 0


func freeze():
	frozen = true
	$face.frame = 2
	$face.visible = true
	$Sprite2D.modulate = Color(0.0, 0.5, 1.0)
	await get_tree().create_timer(freeze_time).timeout
	$AnimationPlayer.play("shake")
	await get_tree().create_timer(shake_time).timeout
	$AnimationPlayer.play("walk")
	frozen = false
	shake = false
	reset_sprite_color()
	$face.visible = false

func freeze_color(color_to_freeze):
	print_debug("color_choice: " + str(color_choice))
	print_debug("color_to_freeze: " + str(color_to_freeze))
	
	var color_to_check
	match color_choice:
		ColorType.RED:
			color_to_check = GameEvents.ColorCombo.RED_RED
		ColorType.GREEN:
			color_to_check = GameEvents.ColorCombo.GREEN_GREEN
		ColorType.GREY:
			color_to_check = GameEvents.ColorCombo.GREY_GREY
	
	
	if color_to_check == color_to_freeze:
		freeze()
	elif color_to_freeze == GameEvents.ColorCombo.PURPLE_PURPLE:
		freeze()
	elif color_to_freeze == GameEvents.ColorCombo.SUPER_PURPLE:
		freeze()
