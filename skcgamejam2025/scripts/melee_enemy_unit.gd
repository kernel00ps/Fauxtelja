extends EnemyUnit
class_name MeleeEnemy

func start_turn():
	can_act = true

	await get_tree().create_timer(0.3).timeout

	var player = get_closest_player()
	if player == null:
		end_turn()
		return

	var to_player = player.global_position - global_position
	var tile_distance = int(to_player.length() / Globals.TILE_SIZE)

	if tile_distance <= 1:
		print("%s (MeleeEnemy) attacks all adjacent tiles!" % self.name)
	else:
		move_toward_player(player)

	end_turn()
