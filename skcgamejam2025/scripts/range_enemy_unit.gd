extends EnemyUnit
class_name RangedEnemy

func start_turn():
	super.start_turn()

	await get_tree().create_timer(0.3).timeout

	var player = get_closest_player()
	if player == null:
		end_turn()
		return

	var to_player = player.global_position - global_position
	var tile_distance = int(to_player.length() / Globals.TILE_SIZE)

	var is_cardinal = abs(to_player.x) < Globals.TILE_SIZE * 0.5 or abs(to_player.y) < Globals.TILE_SIZE * 0.5

	if tile_distance <= 3 and is_cardinal:
		if gun:
			gun.look_at(player.global_position)
			gun.fire()
			print("%s (RangedEnemy) shot at %s" % [self.name, player.name])
	elif tile_distance <= 5:
		move_toward_player(player)

	end_turn()
