extends Marker2D


var customer_scene := preload("res://customer.tscn")
var average_wait_time := 15.0
var wait_time := 5.0
var first_wave_spawned := false

func _ready():
	GameEvents.win_game.connect(on_game_win)
	pick_random_wait_time()
	start_speed_up_timer()

func pick_random_wait_time():
	if not first_wave_spawned:
		wait_time = .5
		first_wave_spawned = true
	else:
		wait_time = randf_range(average_wait_time - 6.0, average_wait_time + 6.0)
	await get_tree().create_timer(wait_time).timeout
	var cust := customer_scene.instantiate()
	add_sibling(cust)
	cust.position = position
	pick_random_wait_time()


func start_speed_up_timer():
	await get_tree().create_timer(average_wait_time * 2).timeout
	if average_wait_time > 10:
		average_wait_time -= 2
		start_speed_up_timer()


func on_game_win():
	queue_free()
