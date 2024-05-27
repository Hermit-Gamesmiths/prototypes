extends Area2D


var player_overlapping := false
var cooking := false
var timer := 0.0
var cooking_time := 10.0
var done_cooking := false
# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	$TextureProgressBar.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not GameEvents.is_on_tapper_scene:
		if player_overlapping and Input.is_action_just_pressed("attack") and not cooking:
			add_food()
		elif player_overlapping and Input.is_action_just_pressed("attack") and done_cooking:
			harvest()
			done_cooking = false
			cooking = false
			timer = 0.0
		
		
		if cooking:
			timer += delta
			$TextureProgressBar.value = timer
			if timer >= cooking_time:
				$Sprite2D.frame = 4
				$TextureProgressBar.visible = false
				$TextureProgressBar.value = 0.0
				done_cooking = true
			



func harvest():
	var drop_scene = load("res://drop.tscn").instantiate()
	add_sibling(drop_scene)
	drop_scene.position = position
	drop_scene.setSpriteColors(GameEvents.ColorCombo.PURPLE_PURPLE)
	$Sprite2D.frame = 0
	player_overlapping = false

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_overlapping = true


func _on_body_exited(body):
	if body.is_in_group("player"):
		player_overlapping = false


func add_food():
	var last_item = GameEvents.inventory.pop_back()
	GameEvents.remove_last_inventory_item.emit()
	if last_item != null:
		$Sprite2D.frame += 1
		if $Sprite2D.frame == 3:
			cooking = true
			$TextureProgressBar.visible = true
