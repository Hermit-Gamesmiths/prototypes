extends Camera2D

var active := false

# Called when the node enters the scene tree for the first time.
func _ready():
	GameEvents.player_toggled_tapper.connect(_on_tapper_toggle)


func _on_tapper_toggle():
	enabled = not enabled

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
