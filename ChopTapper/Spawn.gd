extends Marker2D

@export var override_color: bool = true
@export_range(0, 1) var color_bias: float = .95
@export var color_preference: Enemy.ColorType


var enemy_scene := load("res://enemy.tscn")
var enemy_instance: Enemy = null
var spawning := true
const SPAWN_TIME := 35.0


# Called when the node enters the scene tree for the first time.
func _ready():
	add_enemy()

func add_enemy():
	enemy_instance = enemy_scene.instantiate()
	if override_color:
		enemy_instance.set_color = get_color()

	$sparks.emitting = true
	await get_tree().create_timer(1).timeout
	add_sibling(enemy_instance)
	enemy_instance.position = position
	spawning = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
var spawn_timer = 0.0
var spawn_interval = 0.0

func _process(delta):
	if not GameEvents.is_on_tapper_scene:
		if not is_instance_valid(enemy_instance) and not spawning:
			start_spawn_timer()
			spawning = true

		if spawning:
			spawn_timer -= delta
			if spawn_timer <= 0:
				add_enemy()
				spawning = false

func start_spawn_timer():
	spawn_interval = randf_range(SPAWN_TIME-5, SPAWN_TIME+5)
	spawn_timer = spawn_interval

func get_color() -> Enemy.ColorType:
	var is_biased = randf() < color_bias
	if is_biased:
		return color_preference

	# Generate a random number between 0 and 2 to represent the color choice
	var random_color = randi() % 3

	# Assign the color based on the random number
	match random_color:
		0:
			return Enemy.ColorType.RED
		1:
			return Enemy.ColorType.GREEN
		2:
			return Enemy.ColorType.GREY
	return color_preference
