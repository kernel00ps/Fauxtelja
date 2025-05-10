extends EnemyUnit
class_name RangedEnemy

var bullet_path = preload("res://scenes/pljuca.tscn")

func start_turn():
	can_act = true
	
	await get_tree().create_timer(0.3).timeout

	var player = get_closest_player()
	if player == null:
		end_turn()
		return

	var to_player = player.global_position - global_position
	var tile_distance = int(to_player.length() / Globals.TILE_SIZE)

	var is_cardinal = abs(to_player.x) < Globals.TILE_SIZE * 0.5 or abs(to_player.y) < Globals.TILE_SIZE * 0.5

	if tile_distance <= 3 and is_cardinal:
		shoot()
		print("%s (RangedEnemy) shot at %s" % [self.name, player.name])
	elif tile_distance <= 5:
		move_toward_player(player)

	end_turn()

func shoot() -> void:
	var bullet: Pljuca = bullet_path.instantiate()
	bullet.direction = Vector2(cos(rotation), sin(rotation))  # Direction based on angle

	bullet.position = get_global_position()
	get_tree().current_scene.add_child(bullet)
