extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	area_entered.connect(_DELETE)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _DELETE(area):
	if area.is_in_group("food"):
		area.queue_free()
