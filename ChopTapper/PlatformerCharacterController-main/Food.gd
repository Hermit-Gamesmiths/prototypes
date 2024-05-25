class_name Food
extends Area2D

@onready var sprite_primary := $Primary
@onready var sprite_secondary := $Secondary
var speed := 290.0
var food_color
var super_food := 0
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x -= speed*delta
	await get_tree().create_timer(0.1).timeout


func setSpriteColors(combination):
	food_color = combination
	match combination:
		GameEvents.ColorCombo.RED_RED:
			sprite_primary.modulate = Color(1, 0, 0)  # Red
			sprite_secondary.modulate = Color(1, 0, 0)  # Red
		GameEvents.ColorCombo.RED_GREY:
			sprite_primary.modulate = Color(1, 0, 0)  # Red
			sprite_secondary.modulate = Color(0.5, 0.5, 0.5)  # Grey
		GameEvents.ColorCombo.RED_GREEN:
			sprite_primary.modulate = Color(1, 0, 0)  # Red
			sprite_secondary.modulate = Color(0, 1, 0)  # Green
		GameEvents.ColorCombo.GREEN_GREEN:
			sprite_primary.modulate = Color(0, 1, 0)  # Green
			sprite_secondary.modulate = Color(0, 1, 0)  # Green
		GameEvents.ColorCombo.GREEN_GREY:
			sprite_primary.modulate = Color(0, 1, 0)  # Green
			sprite_secondary.modulate = Color(0.5, 0.5, 0.5)  # Grey
		GameEvents.ColorCombo.GREY_GREY:
			sprite_primary.modulate = Color(0.5, 0.5, 0.5)  # Grey
			sprite_secondary.modulate = Color(0.5, 0.5, 0.5)  # Grey
		GameEvents.ColorCombo.PURPLE_PURPLE:
			sprite_primary.modulate = Color(0.75, 0, 1)  # Purple
			sprite_secondary.modulate = Color(0.55, 0, 1)  # Purple
		GameEvents.ColorCombo.SUPER_RED:
			sprite_primary.modulate = Color(1, 0, 0)  # Red
			sprite_secondary.modulate = Color(1, 0, 0)  # Red
			super_food = 3
		GameEvents.ColorCombo.SUPER_GREEN:
			sprite_primary.modulate = Color(0, 1, 0)  # Green
			sprite_secondary.modulate = Color(0, 1, 0)  # Green
			super_food = 3
		
		GameEvents.ColorCombo.SUPER_GREY:
			sprite_primary.modulate = Color(0.5, 0.5, 0.5)  # Grey
			sprite_secondary.modulate = Color(0.5, 0.5, 0.5)  # Grey
			super_food = 3
		GameEvents.ColorCombo.SUPER_PURPLE:
			sprite_primary.modulate = Color(0.75, 0, 1)  # Purple
			sprite_secondary.modulate = Color(0.55, 0, 1)  # Purple
			super_food = 5
