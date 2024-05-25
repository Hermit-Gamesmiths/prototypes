extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	GameEvents.add_inventory_item.connect(_on_add_inventory_item)
	GameEvents.remove_last_inventory_item.connect(_on_remove_item)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_add_inventory_item(color_combo):
	var inventory_full = true  # Assume inventory is full initially

	for i in get_children():
		if i.empty:
			i.set_sprites_to_reg()
			if color_combo == GameEvents.ColorCombo.SUPER_GREEN \
			or color_combo == GameEvents.ColorCombo.SUPER_RED \
			or color_combo == GameEvents.ColorCombo.SUPER_GREY \
			or color_combo == GameEvents.ColorCombo.SUPER_PURPLE:
				i.set_sprites_to_super()
			
			i.setSpriteColors(color_combo)
			i.empty = false
			inventory_full = false  # Inventory is not full as there's an empty slot
			break  # Exit the loop since an empty slot was found

	if inventory_full:
		GameEvents.inventory_full.emit(true)
		print("emitted inventory full")


func _on_remove_item():
	var children = get_children()
	for i in range(children.size() - 1, -1, -1):
		var child = children[i]
		if not child.empty:
			child.empty = true
			child.setSpriteColors(null)
			# Optionally, you can reset the sprite colors or perform other actions here
			break  # Exit the loop since the last non-empty slot was found
