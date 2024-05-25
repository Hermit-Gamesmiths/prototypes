extends Area2D


var player_overlapping := false
var cooking := false
var timer := 0.0
var cooking_time := 15.0
var done_cooking := false
# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureProgressBar.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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


func add_food():
	if not cooking and not done_cooking:
		var last_item = GameEvents.inventory.pop_back()
		if last_item != null:
			var color_combo = last_item
			if color_combo == GameEvents.ColorCombo.SUPER_GREEN \
			or color_combo == GameEvents.ColorCombo.SUPER_RED \
			or color_combo == GameEvents.ColorCombo.SUPER_GREY \
			or color_combo == GameEvents.ColorCombo.SUPER_PURPLE:
				$"../Beast/InventoryItem".set_sprites_to_super()
			GameEvents.remove_last_inventory_item.emit()
			$Sprite2D.frame += 1
			if $Sprite2D.frame == 3:
				cooking = true
				$TextureProgressBar.visible = true
	elif done_cooking:
		GameEvents.inventory.append(GameEvents.ColorCombo.PURPLE_PURPLE)
		GameEvents.add_inventory_item.emit(GameEvents.ColorCombo.PURPLE_PURPLE)
		$Sprite2D.frame = 0
		cooking = false
		done_cooking = false
		timer = 0.0
