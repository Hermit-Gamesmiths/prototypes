extends Area2D


var player_overlapping := false
var cooking := false
var timer := 0.0
var cooking_time := 15.0
var done_cooking := false
var patience := 60.0
var patience_tracker := patience

func _ready():
	$TextureProgressBar.visible = true
	$TextureProgressBar2.max_value = patience

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	patience_tracker -= delta
	$TextureProgressBar2.value = patience_tracker

func add_food():
	var last_item = GameEvents.inventory.pop_back()
	if last_item != null:
		var color_combo = last_item
		if color_combo == GameEvents.ColorCombo.SUPER_GREEN \
		or color_combo == GameEvents.ColorCombo.SUPER_RED \
		or color_combo == GameEvents.ColorCombo.SUPER_GREY \
		or color_combo == GameEvents.ColorCombo.SUPER_PURPLE:
			$"../Beast/InventoryItem".set_sprites_to_super()
		GameEvents.remove_last_inventory_item.emit()
		$TextureProgressBar.value += 1
		if $TextureProgressBar.value == $TextureProgressBar.max_value:
			GameEvents.win_game.emit()


