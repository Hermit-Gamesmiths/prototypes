extends Area2D


var player_in_area := false


func _process(delta):
	if Input.is_action_just_pressed("pause") and player_in_area:
		GameEvents.player_toggled_tapper.emit()

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_in_area = true


func _on_body_exited(body):
	if body.is_in_group("player"):
		player_in_area = false
