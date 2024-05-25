extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.area_entered.connect(_on_area_entered)
	GameEvents.earned_money.connect(_on_money_earned)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	if area.is_in_group("food"):
		area.queue_free()
		value += 1
		if value >= max_value:
			print(".......YOU WIN.........")


func _on_money_earned():
	value += 1
	if value >= max_value:
		GameEvents.win_game.emit()
