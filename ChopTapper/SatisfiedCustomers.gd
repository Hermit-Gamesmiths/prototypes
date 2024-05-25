extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	area_entered.connect(on_area_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func on_area_entered(area):
	if area.is_in_group("customer"):
		area.pay_and_leave()
