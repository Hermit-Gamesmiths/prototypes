extends Node2D

@onready var m0 := $"../Marker2D5"
@onready var m1 := $"../Marker2D"
@onready var m2 := $"../Marker2D2"
@onready var m3 := $"../Marker2D3"
@onready var m4 := $"../Marker2D4"


var currentMarker
var food_scene := preload("res://food.tscn")
var current_colors

var inventory = []
# Called when the node enters the scene tree for the first time.
func _ready():
	$InventoryItem.visible = false
	currentMarker = m2
	GameEvents.add_inventory_item.connect(_on_add_inventory_item)
	GameEvents.remove_last_inventory_item.connect(_on_remove_last)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_up") and GameEvents.is_on_tapper_scene:
		changeMarker("up")
	elif Input.is_action_just_pressed("ui_down") and GameEvents.is_on_tapper_scene:
		changeMarker("down")
	elif Input.is_action_just_pressed("attack") and GameEvents.is_on_tapper_scene:
		if currentMarker != m0:
			fling_food()
		else:
			add_food_to_beast()
	

func changeMarker(direction):
	if direction == "up":
		if currentMarker == m1:
			currentMarker = m0
		elif currentMarker == m2:
			currentMarker = m1
		elif currentMarker == m3:
			currentMarker = m2
		elif currentMarker == m4:
			currentMarker = m3
	elif direction == "down":
		if currentMarker == m0:
			currentMarker = m1
		elif currentMarker == m1:
			currentMarker = m2
		elif currentMarker == m2:
			currentMarker = m3
		elif currentMarker == m3:
			currentMarker = m4
		

	# Set the player's position to the current marker's position
	# This assumes you have a function in the Marker2D scripts to get their positions
	global_position = currentMarker.global_position
	
func _on_add_inventory_item(color_combo):
	$InventoryItem.visible = true
	$InventoryItem.set_sprites_to_reg()
	if color_combo == GameEvents.ColorCombo.SUPER_GREEN \
	or color_combo == GameEvents.ColorCombo.SUPER_RED \
	or color_combo == GameEvents.ColorCombo.SUPER_GREY \
	or color_combo == GameEvents.ColorCombo.SUPER_PURPLE:
		$InventoryItem.set_sprites_to_super()
	current_colors = color_combo
	inventory.append(color_combo)
	$InventoryItem.setSpriteColors(color_combo)


func _on_remove_last():
	
	$InventoryItem.setSpriteColors(GameEvents.inventory.back())

func fling_food():
	$InventoryItem.set_sprites_to_reg()
	var last_item = GameEvents.inventory.pop_back()
	GameEvents.remove_last_inventory_item.emit()
	$InventoryItem.setSpriteColors(GameEvents.inventory.back())
	
	var color_combo = GameEvents.inventory.back()
	
	if color_combo == GameEvents.ColorCombo.SUPER_GREEN \
	or color_combo == GameEvents.ColorCombo.SUPER_RED \
	or color_combo == GameEvents.ColorCombo.SUPER_GREY \
	or color_combo == GameEvents.ColorCombo.SUPER_PURPLE:
		$InventoryItem.set_sprites_to_super()
	
	if last_item == null:
		$InventoryItem.visible = false
	else:
		var food_inst = food_scene.instantiate()
		add_sibling(food_inst)
		food_inst.setSpriteColors(last_item)
		food_inst.position = currentMarker.position
		if GameEvents.inventory.back() == null:
			$InventoryItem.visible = false


func add_food_to_crockpot():
	
	$"../Crockpot".add_food()
	

func add_food_to_beast():
	$"../Beast2".add_food()
