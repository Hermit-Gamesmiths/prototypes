extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	visible = true
	GameEvents.lose_game.connect(game_end)


func game_end():
	visible = true
