extends Marker2D


var enemy_scene := load("res://enemy.tscn")
var enemy_instance = null
var spawning := true
# Called when the node enters the scene tree for the first time.
func _ready():
	add_enemy()

func add_enemy():
	enemy_instance = enemy_scene.instantiate()
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
	spawn_interval = randf_range(20, 25)
	spawn_timer = spawn_interval
