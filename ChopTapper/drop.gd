extends Area2D


var color_combo := GameEvents.ColorCombo.RED_RED
var player_detected := false
@onready var sprite_primary := $Sprite
@onready var sprite_secondary := $Sprite2
var picked_up := false
var inventory_full := false
@onready var player = $"../Player"

# Called when the node enters the scene tree for the first time.
func _ready():
	setSpriteColors(color_combo)
	body_entered.connect(_on_body_entered)
	$ProximityDetect.body_exited.connect(_on_body_exited_prox)
	$ProximityDetect.body_entered.connect(_on_body_entered_prox)
	await get_tree().create_timer(5.0).timeout
	queue_free()


# Function to set the modulate color of sprites based on color combination
func setSpriteColors(combination):
	color_combo = combination
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
		
		GameEvents.ColorCombo.SUPER_GREEN:
			sprite_primary.modulate = Color(0, 1, 0)  # Green
			sprite_secondary.modulate = Color(0, 1, 0)  # Green
			
		GameEvents.ColorCombo.SUPER_GREY:
			sprite_primary.modulate = Color(0.5, 0.5, 0.5)  # Grey
			sprite_secondary.modulate = Color(0.5, 0.5, 0.5)  # Grey
		
		GameEvents.ColorCombo.SUPER_PURPLE:
			sprite_primary.modulate = Color(0.75, 0, 1)  # Purple
			sprite_secondary.modulate = Color(0.55, 0, 1)  # Purple



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_detected and not player.inventory_full:
		var player_pos = player.global_position
		
		position.x = move_toward(position.x, player_pos.x, 3.0)
		position.y = move_toward(position.y, player_pos.y, 3.0)


func _on_body_entered(body):
	if body is PlatformerController and not picked_up and not player.inventory_full:
		picked_up = true
		$Sprite.visible = false
		$Sprite2.visible = false
		monitoring = false
		GameEvents.inventory.append(color_combo)
		GameEvents.add_inventory_item.emit(color_combo)
		await get_tree().create_timer(2.0).timeout
		queue_free()

func _on_body_entered_prox(body):
	if body is PlatformerController and not player.inventory_full:
		player_detected = true

func _on_body_exited_prox(body):
	if body is PlatformerController and not player.inventory_full:
		player_detected = false



