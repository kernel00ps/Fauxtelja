extends EnemyUnit
class_name RangedEnemy

var bullet_path = preload("res://scenes/pljuca.tscn")

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

	var is_cardinal = abs(to_player.x) < Globals.TILE_SIZE * 0.5 or abs(to_player.y) < Globals.TILE_SIZE * 0.5

	if tile_distance <= 3 and is_cardinal:
		shoot()
		print("%s (RangedEnemy) shot at %s" % [self.name, player.name])
	elif tile_distance <= 5:
		move_toward_player(player)

	end_turn()

func face_direction(direction: String) -> void:
	var anim_name = "idle_%s" % direction
	if body_sprite.sprite_frames.has_animation(anim_name):
		body_sprite.play(anim_name)
	else:
		push_warning("No animation '%s' on %s" % [anim_name, body_sprite.name])

func shoot() -> void:
	var player = get_closest_player()
	if player == null:
		return

	var bullet: Pljuca = bullet_path.instantiate()

	var to_player = player.global_position - global_position
	var angle = to_player.angle()

	bullet.direction = to_player.normalized()
	
	var dir_str: String
	if abs(angle) < PI / 4:
		dir_str = "right"
	elif abs(angle) > 3 * PI / 4:
		dir_str = "left"
	elif angle < 0:
		dir_str = "up"
	else:
		dir_str = "down"

	# turn then shoot
	face_direction(dir_str)
	play_attack_animation(dir_str)

	bullet.position = global_position
	get_tree().current_scene.add_child(bullet)
	BackgroundMusic.pljuca.emit()

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
			node.play("spit_%s" % dir)
		else:
			node.stop()
			node.frame = 0
			node.visible = false
