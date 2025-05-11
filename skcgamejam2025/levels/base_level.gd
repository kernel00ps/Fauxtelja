extends Node2D

class_name BaseLevel

func _ready():
	initiate_turn_manager()

func initiate_turn_manager() -> void:
	TurnManager.player_units = [$Player]
	TurnManager.enemy_units.clear()
	var enemies_node = $Enemies
	
	for enemy in enemies_node.get_children():
		if enemy is EnemyUnit:
			TurnManager.enemy_units.append(enemy)
	TurnManager.start_turn()

func set_camera_boundaries(left : int, right : int, down : int, top : int) -> void:
	Globals.player.get_camera().limit_bottom = down;
	Globals.player.get_camera().limit_left = left;
	Globals.player.get_camera().limit_right = right;
	Globals.player.get_camera().limit_top = top;

func set_camera_boundaries_from_tilemap(tilemap: TileMap) -> void:
	var used_rect = tilemap.get_used_rect()
	var cell_size = tilemap.tile_set.tile_size
	
	var left = used_rect.position.x * cell_size.x
	var top = used_rect.position.y * cell_size.y
	var right = (used_rect.position.x + used_rect.size.x) * cell_size.x
	var bottom = (used_rect.position.y + used_rect.size.y) * cell_size.y

	var camera = Globals.player.get_camera()
	camera.limit_left = left
	camera.limit_right = right
	camera.limit_top = top
	camera.limit_bottom = bottom


func get_used_rect_for_layer(tilemap: TileMapLayer) -> void:
	var used_rect = tilemap.get_used_rect()
	var cell_size = tilemap.tile_set.tile_size
	
	var left = used_rect.position.x * cell_size.x
	var top = used_rect.position.y * cell_size.y
	var right = (used_rect.position.x + used_rect.size.x) * cell_size.x
	var bottom = (used_rect.position.y + used_rect.size.y) * cell_size.y

	var camera = Globals.player.get_camera()
	camera.limit_left = left
	camera.limit_right = right
	camera.limit_top = top
	camera.limit_bottom = bottom
