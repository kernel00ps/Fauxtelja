extends Unit

func _unhandled_input(event: InputEvent) -> void:
	if not can_act:
		return

	var dir := Vector2.ZERO

	if event.is_action_pressed("TOP"):
		dir = Vector2(0, -1)
	elif event.is_action_pressed("DOWN"):
		dir = Vector2(0, 1)
	elif event.is_action_pressed("LEFT"):
		dir = Vector2(-1, 0)
	elif event.is_action_pressed("RIGHT"):
		dir = Vector2(1, 0)

	if dir != Vector2.ZERO:
		move_tile(dir)

func move_tile(dir: Vector2) -> void:
	position += dir * tile_size
	end_turn()
