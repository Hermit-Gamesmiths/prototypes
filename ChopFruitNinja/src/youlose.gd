extends CanvasLayer

var enable := false
# Called when the node enters the scene tree for the first time.
func _ready():
	GameEvents.lose.connect(on_lose)
	$Button.pressed.connect(_restart)
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible:
		if Input.is_anything_pressed() and enable:
			_restart()


func on_lose():
	visible = true
	await get_tree().create_timer(1.0).timeout
	enable = true

func _restart():
	get_tree().paused = false
	get_tree().reload_current_scene()
