extends Sprite2D


func _ready():
	sprite_to_polygon()


func sprite_to_polygon():
	var data = texture.get_image()
	
	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(data)
	
	var polys = bitmap.opaque_to_polygons(
		Rect2(
			Vector2.ZERO,
			texture.get_size()
		),
		5
	)
	
	$"../CollisionPolygon2D".polygon = polys
	
