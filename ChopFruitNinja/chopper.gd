extends Area2D

var value:= 0

# Called when the node enters the scene tree for the first time.
func _ready():
	area_entered.connect(_on_area_ent)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_ent(area):
	if area.is_in_group("cut_area"):
		value += area.value
		$Label.text = str(value)
		GameEvents.slice_scored.emit(area.value)
		area.on_pickup()
	elif area.is_in_group("bone"):
		queue_free()
	elif area.is_in_group("purple_bonus"):
		GameEvents.add_item(GameEvents.ColorType.PURPLE, 5)
		area.queue_free()


func _exit_tree():
	GameEvents.chop_finished.emit()
