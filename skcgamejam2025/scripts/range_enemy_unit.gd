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
	var player = get_closest_player()
	if player == null:
		return

	var bullet: Pljuca = bullet_path.instantiate()

	var to_player = player.global_position - global_position
	bullet.direction = to_player.normalized()

	var angle = to_player.angle()
	if abs(angle) < PI / 4:
		current_direction = "right"
	elif abs(angle) > 3 * PI / 4:
		current_direction = "left"
	elif angle < 0:
		current_direction = "up"
	else:
		current_direction = "down"

	#play_attack_animation(current_direction)

	bullet.position = global_position
	get_tree().current_scene.add_child(bullet)

func play_attack_animation(direction: String) -> void:
	var directions = ["up", "down", "left", "right"]
	for dir in directions:
		var sprite_node = $"attack_%s" % dir
		sprite_node.visible = (dir == direction)
		if dir == direction:
			sprite_node.play("spit_%s" % dir)
