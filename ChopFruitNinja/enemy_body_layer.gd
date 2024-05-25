extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	GameEvents.enemy_died.connect(_on_e_die)
	GameEvents.chop_finished.connect(_on_chop_finished)

func _on_chop_finished():
	await get_tree().create_timer(0.5).timeout
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_e_die(pos):
	visible = true


