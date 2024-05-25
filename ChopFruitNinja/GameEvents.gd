extends Node

signal sliced_meat
signal slice_scored(score: float)
signal enemy_died(color)
enum ColorType { RED, GREEN, GREY, PURPLE }
signal chop_finished
signal scored
signal win
signal lose
signal restart

var paused := false
var purple_counter_amount := 15
var purple_counter := purple_counter_amount

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	enemy_died.connect(_on_enemy_death)
	chop_finished.connect(_on_chop_fin)
	win.connect(_reset)
	lose.connect(_reset)
	restart.connect(_reset)


func _on_enemy_death(pos):
	paused = true


func _on_chop_fin():
	await get_tree().create_timer(0.5).timeout
	paused = false


var inventory = []


func add_item(color, value):
	var color_string := "Grey"
	if color == ColorType.PURPLE:
		color_string = "Purple"
	elif color == ColorType.RED:
		color_string = "Red"
	elif color == ColorType.GREEN:
		color_string = "Green"
	if value >= 1 and value <= 5:
		var item = {"color": color_string, "value": value}
		inventory.append(item)
		print("Added item: ", item)
	else:
		print("Invalid value. Value must be between 1 and 5.")


func remove_item(index):
	if index >= 0 and index < inventory.size():
		var item = inventory[index]
		inventory.remove(index)
		print("Removed item: ", item)
	else:
		print("Invalid index. Index out of range.")

func get_item(index):
	if index >= 0 and index < inventory.size():
		return inventory[index]
	else:
		print("Invalid index. Index out of range.")
		return null

func get_inventory():
	return inventory
	


var requests = []

func _reset():
	requests = []
	inventory = []
