extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	area_entered.connect(_on_area_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	if area.is_in_group("customer"):
		GameEvents.lose_game.emit()
