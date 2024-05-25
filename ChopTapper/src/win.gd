extends CanvasLayer

@onready var buttn: Button = $Button
# Called when the node enters the scene tree for the first time.
func _ready():
	GameEvents.win_game.connect(_on_win)
	buttn.pressed.connect(_on_button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_win():
	$"../TapperView".visible = true
	await get_tree().create_timer(3.0).timeout
	visible = true


func _on_button_pressed():
	GameEvents.inventory = []
	GameEvents.is_on_tapper_scene = false
	get_tree().reload_current_scene()
