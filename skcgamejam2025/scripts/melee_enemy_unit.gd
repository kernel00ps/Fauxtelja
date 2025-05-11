extends EnemyUnit
class_name MeleeEnemy

@onready var body_sprite: AnimatedSprite2D = $idle

func start_turn():
	can_act = true

	var thinking_time = randf_range(thinking_time_range.x, thinking_time_range.y)
	await get_tree().create_timer(thinking_time).timeout

	# Chance to skip turn
	if randf() < idle_chance:
		print("%s (RangedEnemy) skipped turn due to idle chance" % name)
		end_turn()
		return

	var player = get_closest_player()
	if player == null:
		end_turn()
		return

	var to_player = player.global_position - global_position
	var tile_distance = int(to_player.length() / Globals.TILE_SIZE)

	if tile_distance <= 1:
		var angle = to_player.angle()
		var dir_str: String
		if abs(angle) < PI / 4:
			dir_str = "right"
		elif abs(angle) > 3 * PI / 4:
			dir_str = "left"
		elif angle < 0:
			dir_str = "up"
		else:
			dir_str = "down"
		face_direction(dir_str)
		play_attack_animation(dir_str)
		melee_attack()
		print("%s (MeleeEnemy) attacks all adjacent tiles!" % self.name)
	else:
		move_toward_player(player)

	end_turn()
	
func melee_attack() -> void:
	var directions = [
	Vector2(Globals.TILE_SIZE, 0),
	Vector2(-Globals.TILE_SIZE, 0),
	Vector2(0, Globals.TILE_SIZE),
	Vector2(0, -Globals.TILE_SIZE),
	Vector2(Globals.TILE_SIZE, Globals.TILE_SIZE),
	Vector2(Globals.TILE_SIZE, -Globals.TILE_SIZE),
	Vector2(-Globals.TILE_SIZE, Globals.TILE_SIZE),
	Vector2(-Globals.TILE_SIZE, -Globals.TILE_SIZE)
	]

	var space_state = get_world_2d().direct_space_state

	for dir in directions:
		var check_pos = global_position + dir

		var params = PhysicsPointQueryParameters2D.new()
		params.position = check_pos
		params.collide_with_areas = false
		params.collide_with_bodies = true

		var results = space_state.intersect_point(params)

		for result in results:
			if result.collider is Player:
				result.collider.die()
				
func face_direction(direction: String) -> void:
	var anim_name = "idle_%s" % direction
	if body_sprite.sprite_frames.has_animation(anim_name):
		body_sprite.play(anim_name)
	else:
		push_warning("No animation '%s' on %s" % [anim_name, body_sprite.name])

func play_attack_animation(direction: String) -> void:
	for dir in ["right", "left", "up", "down"]:
		var node = get_node_or_null("attack_%s" % dir) as AnimatedSprite2D
		if node == null:
			push_warning("attack_%s not found!" % dir)
			continue

		if dir == direction:
			node.visible = true
			node.stop()
			node.frame = 0
			node.play("lick_%s" % dir)
		else:
			node.stop()
			node.frame = 0
			node.visible = false
