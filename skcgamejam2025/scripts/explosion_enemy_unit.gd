extends EnemyUnit
class_name ExplosionEnemy

@export var explosion_effect: PackedScene

func start_turn():
	can_act = true

	await get_tree().create_timer(0.3).timeout

	var player = get_closest_player()
	if player == null:
		end_turn()
		return

	var to_player = player.global_position - global_position
	var tile_distance = int(to_player.length() / Globals.TILE_SIZE)

	if tile_distance <= 2:
		_explode()
	else:
		print("%s (ExplosionEnemy) waits." % self.name)

	end_turn()

func _explode():
	var explosion = explosion_effect.instantiate()
	explosion.global_position = global_position
	get_tree().current_scene.add_child(explosion)
	queue_free()
