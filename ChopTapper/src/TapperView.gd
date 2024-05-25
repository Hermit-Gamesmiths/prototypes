extends CanvasLayer



# Called when the node enters the scene tree for the first time.
func _ready():
	GameEvents.lose_game.connect(game_end)
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause") and not visible:
		GameEvents.is_on_tapper_scene = true
		#get_tree().paused = true
		visible = true
	elif Input.is_action_just_pressed("pause"):
		GameEvents.is_on_tapper_scene = false
		#get_tree().paused = false
		visible = false


func game_end():
	visible = true
