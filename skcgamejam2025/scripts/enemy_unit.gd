extends Unit
class_name EnemyUnit

@export var gun: Gun 
@onready var sprite: AnimatedSprite2D = $idle

func start_turn():
	super.start_turn()

	await get_tree().create_timer(0.3).timeout

	var player = get_closest_player()
	if player == null:
		end_turn()
		return

	var to_player = player.global_position - global_position
	var tile_distance = int(to_player.length() / Globals.TILE_SIZE)

	if tile_distance <= 5:
		if gun:
			gun.look_at(player.global_position)
			gun.fire()
			print("%s (Enemy) shot at %s" % [self.name, player.name])
	else:
		move_toward_player(player)

	end_turn()


func move_toward_player(player: Node2D) -> void:
	var to_player = player.global_position - global_position
	var preferred_steps := []

	# Determine preferred step directions (cardinal only)
	if abs(to_player.x) > abs(to_player.y):
		preferred_steps.append(Vector2(sign(to_player.x), 0))  # Horizontal first
		preferred_steps.append(Vector2(0, sign(to_player.y)))
	else:
		preferred_steps.append(Vector2(0, sign(to_player.y)))  # Vertical first
		preferred_steps.append(Vector2(sign(to_player.x), 0))

	# Add perpendicular alternatives as fallback
	preferred_steps.append(Vector2(-sign(to_player.x), 0))
	preferred_steps.append(Vector2(0, -sign(to_player.y)))

	for step in preferred_steps:
		var new_position = global_position + step * Globals.TILE_SIZE

		# Avoid moving into player
		if new_position.distance_to(player.global_position) < Globals.TILE_SIZE * 0.5:
			continue

		# Avoid moving into other enemies
		var blocked := false
		for other_enemy in TurnManager.enemy_units:
			if other_enemy == self:
				continue
			if other_enemy.global_position.distance_to(new_position) < Globals.TILE_SIZE * 0.5:
				blocked = true
				break

		if blocked:
			continue

		# Perform the move
		global_position = new_position

		# Set animation
		var dir_name: String = ""
		if step.x > 0:
			dir_name = "right"
		elif step.x < 0:
			dir_name = "left"
		elif step.y < 0:
			dir_name = "up"
		elif step.y > 0:
			dir_name = "down"
		
		sprite.animation = "idle_" + dir_name
		sprite.play()

		print("%s (Enemy) moved toward %s" % [self.name, player.name])
		return  # Moved successfully, stop

	print("%s (Enemy) couldn't find path to move!" % self.name)

func get_closest_player() -> Node2D:
	var closest : Player = null
	var min_dist := INF

	for player_unit in TurnManager.player_units:
		var dist = global_position.distance_to(player_unit.global_position)
		if dist < min_dist:
			min_dist = dist
			closest = player_unit

	return closest

func die() -> void:
	if TurnManager.enemy_units.has(self):
		var was_my_turn = (TurnManager.enemy_units[TurnManager.current_unit_index] == self)
		TurnManager.enemy_units.erase(self)
		queue_free()
		if was_my_turn:
			TurnManager.unit_finished_turn()
