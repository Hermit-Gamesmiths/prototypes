extends Node

enum ColorCombo {
	RED_RED,
	RED_GREY,
	RED_GREEN,
	GREEN_GREEN,
	GREEN_GREY,
	GREY_GREY,
	PURPLE_PURPLE,
	SUPER_RED,
	SUPER_GREEN,
	SUPER_GREY,
	SUPER_PURPLE
}

signal player_position
signal add_inventory_item(color_combo)
signal remove_last_inventory_item

signal inventory_full(bool)

signal win_game
signal lose_game

var inventory = []

var is_on_tapper_scene := false

var inventory_signalled := false


var amount_until_purple := 30
var purple_counter := amount_until_purple

signal earned_money
signal player_toggled_tapper
var money_earned := 0
func _ready():
	earned_money.connect(_on_money_earned)
	player_toggled_tapper.connect(_on_player_toggle)

func _on_player_toggle():
	GameEvents.is_on_tapper_scene = not GameEvents.is_on_tapper_scene

func _on_money_earned():
	money_earned += 1

func _process(delta):
	if inventory.size() == 5 and not inventory_signalled:
		print("FULL")
		inventory_full.emit(true)
		inventory_signalled = true
	
	if inventory.size() < 5 and inventory_signalled:
		inventory_full.emit(false)
		inventory_signalled = false
	
