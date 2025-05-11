extends Unit

class_name Player

var action_performed: bool = false
var moved: bool = false

@onready var marker : Sprite2D = $Marker
@onready var target : Sprite2D = $Target

@export var gun : Gun
@export var game_over_screen: PackedScene

var original_position := Vector2.ZERO

func _ready():
	Globals.current_bullets = Globals.max_bullets;
	Globals.player = self
	target.visible = false
	marker.visible = false
	
func _unhandled_input(event: InputEvent) -> void:
	if not can_act:
		target.visible = false
		marker.visible = false
		return
	
	if moved:
		marker.visible = false
	
	var mouse_pos = get_global_mouse_position() - Vector2(Globals.TILE_SIZE, Globals.TILE_SIZE) / 2
	var target_tile = mouse_pos.snapped(Vector2(Globals.TILE_SIZE, Globals.TILE_SIZE))
	var current_tile = get_current_tile()
	var delta_tile = target_tile - current_tile

	var viewport_rect = get_viewport().get_visible_rect()

	var is_adjacent = delta_tile.length() <= Globals.TILE_SIZE * sqrt(2) and delta_tile.length() != 0

	if is_adjacent and viewport_rect.has_point(target_tile):
		var enemy_found = false
		for enemy in TurnManager.enemy_units:
			if enemy == null:
				continue
			var enemy_tile = enemy.get_current_tile()
			if enemy_tile == target_tile:
				enemy_found = true
				break
				
		var found_shootable = false
		var shoot_dir = (target_tile - current_tile).normalized()
		var target_center = get_tile_center(target_tile)

		for node in get_tree().get_nodes_in_group("shootable"):
			if not node.has_method("get_current_tile"):
				continue
			if node.get_current_tile() == target_tile:
				found_shootable = true
				break

		if enemy_found or found_shootable:
			target.global_position = target_tile + Vector2(Globals.TILE_SIZE, Globals.TILE_SIZE) / 2
			marker.visible = false
			target.visible = true
		else:
			marker.global_position = target_tile + Vector2(Globals.TILE_SIZE, Globals.TILE_SIZE) / 2
			marker.rotation = delta_tile.angle() - deg_to_rad(90.0)
			marker.visible = true
			target.visible = false
			
	elif not is_adjacent and not action_performed and viewport_rect.has_point(target_tile) and current_tile != target_tile:
		target.global_position = target_tile + Vector2(Globals.TILE_SIZE, Globals.TILE_SIZE) / 2
		target.visible = true
		marker.visible = false
	else:
		marker.visible = false
		target.visible = false
		
	# Handle mouse click to move
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var enemy_found = false
		for enemy in TurnManager.enemy_units:
			if enemy == null:
				continue
			if enemy.get_current_tile() == target_tile:
				enemy_found = true
				break
				
		var found_shootable = false

		for node in get_tree().get_nodes_in_group("shootable"):
			if not node.has_method("get_current_tile"):
				continue
			if node.get_current_tile() == target_tile:
				found_shootable = true
				break
			
		if not action_performed:
			if enemy_found or found_shootable:
				var shoot_dir = (target_tile - current_tile).normalized()
				action_performed = true
				shoot(shoot_dir)
			elif is_adjacent and not moved:
				try_move_to_tile(target_tile)

func try_move_to_tile(target_tile: Vector2) -> void:
	for enemy in TurnManager.enemy_units:
		if enemy == null:
			continue
		var enemy_tile = enemy.get_current_tile()
		if enemy_tile == target_tile:
			print("Enemy blocking tile.")
			return

	var current_tile = get_current_tile()
	var delta = target_tile - current_tile

	if delta.length() <= Globals.TILE_SIZE * sqrt(2) and delta.length() != 0:
		var viewport_rect = get_viewport().get_visible_rect()
		if viewport_rect.has_point(target_tile):
			position = get_tile_center(target_tile)
			moved = true
			Globals.play_sound.emit('step');
			end_turn()
	else:
		print("Invalid move. Must be to an adjacent tile.")

func shoot(direction: Vector2) -> void:
	print("Shooting in direction %s" % direction)
	
	if(Globals.current_bullets > 0):
		Globals.play_sound.emit('shoot');
		Globals.use_bullet.emit();
		Globals.current_bullets -= 1;
		gun.fire()
		end_turn()
	else:
		Globals.play_sound.emit("nobullets")
		end_turn();


func end_turn():
	if not action_performed and not moved:
		print("Action or movement required before ending turn!")
		return

	action_performed = false
	moved = false
	super.end_turn()

func get_tile_center(tile: Vector2) -> Vector2:
	return tile + Vector2(Globals.TILE_SIZE, Globals.TILE_SIZE) / 2

func die() -> void:
	can_act = false
	TurnManager.stop_turns()
	#TODO: add die animation
	Globals.emit_signal("died")
	Globals.play_sound.emit("death")
	var screen = game_over_screen.instantiate()
	get_tree().current_scene.add_child(screen)

func get_camera() -> Camera2D:
	return $Camera2D
