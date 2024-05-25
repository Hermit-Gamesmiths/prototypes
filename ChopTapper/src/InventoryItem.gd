extends Control

@onready var sprite_primary := $Primary
@onready var sprite_secondary := $Secondary

var empty := true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_sprites_to_super():
	$Primary.texture = load("res://super.png")
	$Secondary.texture = load("res://super.png")

func set_sprites_to_reg():
	$Primary.texture = load("res://drop_ui.png")
	$Secondary.texture = load("res://drop_ui.png")

func setSpriteColors(combination):
	sprite_primary.modulate = Color(1, 1, 1)  # White
	sprite_secondary.modulate = Color(1, 1, 1)  # White
	empty = true
	match combination:
		GameEvents.ColorCombo.RED_RED:
			sprite_primary.modulate = Color(1, 0, 0)  # Red
			sprite_secondary.modulate = Color(1, 0, 0)  # Red
			empty = false
		GameEvents.ColorCombo.RED_GREY:
			sprite_primary.modulate = Color(1, 0, 0)  # Red
			sprite_secondary.modulate = Color(0.5, 0.5, 0.5)  # Grey
			empty = false
		GameEvents.ColorCombo.RED_GREEN:
			sprite_primary.modulate = Color(1, 0, 0)  # Red
			sprite_secondary.modulate = Color(0, 1, 0)  # Green
			empty = false
		GameEvents.ColorCombo.GREEN_GREEN:
			sprite_primary.modulate = Color(0, 1, 0)  # Green
			sprite_secondary.modulate = Color(0, 1, 0)  # Green
			empty = false
		GameEvents.ColorCombo.GREEN_GREY:
			sprite_primary.modulate = Color(0, 1, 0)  # Green
			sprite_secondary.modulate = Color(0.5, 0.5, 0.5)  # Grey
			empty = false
		GameEvents.ColorCombo.GREY_GREY:
			sprite_primary.modulate = Color(0.5, 0.5, 0.5)  # Grey
			sprite_secondary.modulate = Color(0.5, 0.5, 0.5)  # Grey
			empty = false
		GameEvents.ColorCombo.PURPLE_PURPLE:
			sprite_primary.modulate = Color(0.75, 0, 1)  # Purple
			sprite_secondary.modulate = Color(0.55, 0, 1)  # Purple
			
		GameEvents.ColorCombo.SUPER_RED:
			sprite_primary.modulate = Color(1, 0, 0)  # Red
			sprite_secondary.modulate = Color(1, 0, 0)  # Red
			empty = false
		GameEvents.ColorCombo.SUPER_GREEN:
			sprite_primary.modulate = Color(0, 1, 0)  # Green
			sprite_secondary.modulate = Color(0, 1, 0)  # Green
			empty = false
		GameEvents.ColorCombo.SUPER_GREY:
			sprite_primary.modulate = Color(0.5, 0.5, 0.5)  # Grey
			sprite_secondary.modulate = Color(0.5, 0.5, 0.5)  # Grey
			empty = false
		GameEvents.ColorCombo.SUPER_PURPLE:
			sprite_primary.modulate = Color(0.75, 0, 1)  # Purple
			sprite_secondary.modulate = Color(0.55, 0, 1)  # Purple
