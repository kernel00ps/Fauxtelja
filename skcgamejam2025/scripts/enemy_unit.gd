extends Unit
class_name EnemyUnit

@export var gun: Gun 

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
	var direction = to_player.normalized()
	var step = Vector2.ZERO

	# Prefer cardinal axis
	if abs(to_player.x) > abs(to_player.y):
		step.x = sign(to_player.x)
	else:
		step.y = sign(to_player.y)

	var new_position = global_position + step * Globals.TILE_SIZE
	
	if new_position.distance_to(player.global_position) < Globals.TILE_SIZE * 0.5:
		print("Blocked by player")
		return

	global_position = new_position
	print("%s (Enemy) moved toward %s" % [self.name, player.name])


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
