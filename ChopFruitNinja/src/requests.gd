
extends CanvasLayer

func _process(delta):
	# Clear any existing labels
	for child in $VBoxContainer.get_children():
		if child.text != "Requests":
			child.queue_free()

	# Create a new label for each inventory item
	for item in GameEvents.requests:
		var label = Label.new()
		
		# Get the value and color from the item dictionary
		var value = item.get("value", 0)
		var color = item.get("color", "")
		
		# Create a string of emojis based on the value
		var emoji_string = ""
		for _i in range(value):
			emoji_string += "✮"
		
		# Set the label's text to the emoji string
		label.text = emoji_string
		
		# Modulate the label's color based on the color string
		match color:
			"Purple":
				label.modulate = Color(0.5, 0, 0.5)  # Purple color
			"Green":
				label.modulate = Color(0, 1, 0)  # Green color
			"Red":
				label.modulate = Color(1, 0, 0)  # Red color
			"Grey":
				label.modulate = Color(0.5, 0.5, 0.5)  # Grey color
			_:
				label.modulate = Color(1, 1, 1)  # Default color (white)
		
		# Add the label to the VBoxContainer
		$VBoxContainer.add_child(label)
