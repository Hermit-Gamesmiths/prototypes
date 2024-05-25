extends Area2D


var player_overlapping := false
var cooking := false
var timer := 0.0
const  base_cooking_time := 15.0
var cooking_time := base_cooking_time
var done_cooking := false
var contained_food := GameEvents.ColorCombo.PURPLE_PURPLE

# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureProgressBar.visible = false
	$TextureProgressBar.max_value = cooking_time

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameEvents.is_on_tapper_scene:
		if Input.is_action_just_pressed("right"):
			add_food()
	if cooking:
		timer += delta
		$TextureProgressBar.value = timer
		if timer >= cooking_time:
			$Sprite2D.frame = 2
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
	$InventoryItem.visible = false


func add_food():
	$InventoryItem.visible = false
	if not cooking and not done_cooking:
		var last_item = GameEvents.inventory.pop_back()
		if last_item != null:
			$InventoryItem.setSpriteColors(last_item)
			$InventoryItem.visible = true
			contained_food = last_item
			GameEvents.remove_last_inventory_item.emit()
			$Sprite2D.frame += 1
			cooking = true
			if contained_food == GameEvents.ColorCombo.PURPLE_PURPLE:
				cooking_time = base_cooking_time * 1.8
				$TextureProgressBar.max_value = cooking_time
			else:
				cooking_time = base_cooking_time
				$TextureProgressBar.max_value = cooking_time
			$TextureProgressBar.visible = true
	elif done_cooking:
		match contained_food:
			GameEvents.ColorCombo.RED_RED:
				var food = GameEvents.ColorCombo.SUPER_RED
				GameEvents.inventory.append(food)
				GameEvents.add_inventory_item.emit(food)
			GameEvents.ColorCombo.GREEN_GREEN:
				var food = GameEvents.ColorCombo.SUPER_GREEN
				GameEvents.inventory.append(food)
				GameEvents.add_inventory_item.emit(food)
			GameEvents.ColorCombo.GREY_GREY:
				var food = GameEvents.ColorCombo.SUPER_GREY
				GameEvents.inventory.append(food)
				GameEvents.add_inventory_item.emit(food)
			GameEvents.ColorCombo.PURPLE_PURPLE:
				var food = GameEvents.ColorCombo.SUPER_PURPLE
				GameEvents.inventory.append(food)
				GameEvents.add_inventory_item.emit(food)
		
		$Sprite2D.frame = 0
		cooking = false
		done_cooking = false
		timer = 0.0
