extends Area2D

var ingredients_added = 0
var timer = null
var player_in_area := false
var has_cooked_meal := false
func _ready():
	self.body_entered.connect(_on_body_entered)
	self.body_exited.connect(_on_body_exited)
	
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(10)
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

func _process(delta):
	if Input.is_action_just_pressed("attack") and ingredients_added < 3 and player_in_area and not has_cooked_meal:
		if GameEvents.inventory.size() > 0:
			var last_item = GameEvents.inventory.pop_back()
			ingredients_added += 1
			$Sprite2D.frame +=1
			print("Added ingredient: ", last_item)
			
			if ingredients_added == 3:
				print("Maximum ingredients reached. Starting timer.")
				timer.start()
	if Input.is_action_just_pressed("attack") and has_cooked_meal and player_in_area:
		GameEvents.add_item(GameEvents.ColorType.PURPLE, 5)
		has_cooked_meal = false
		$Sprite2D.frame = 0

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_in_area = true


func _on_body_exited(body):
	if body.is_in_group("player"):
		player_in_area = false


func _on_timer_timeout():
	$Sprite2D.frame +=1
	has_cooked_meal = true
	ingredients_added = 0
