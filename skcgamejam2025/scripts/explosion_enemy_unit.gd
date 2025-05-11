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
	var fx = explosion_effect.instantiate()
	fx.global_position = global_position
	fx.one_shot = true
	fx.emitting = true

	get_parent().add_child(fx)
	fx.finished.connect(OnFinishedParticle.bind(fx))

	for player in TurnManager.player_units:
		var dist = global_position.distance_to(player.global_position)
		if dist <= Globals.TILE_SIZE * 2:
			if player.has_method("die"):
				player.die()

	queue_free()

func OnFinishedParticle( explosion ):
	remove_child( explosion )
	explosion.queue_free()
	
