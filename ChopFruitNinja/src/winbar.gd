extends ProgressBar

signal progress_full

@export var increment_amount = 5

func _ready():
	value = 0
	max_value = 100
	progress_full.connect(_on_progress_full)
	GameEvents.scored.connect(increment_progress)

func increment_progress():
	value += increment_amount
	if value >= max_value:
		emit_signal("progress_full")

func _on_progress_full():
	GameEvents.win.emit()
	get_tree().paused = true
