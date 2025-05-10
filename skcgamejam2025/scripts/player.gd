extends Unit

class_name Player

var action_performed: bool = false
var moved: bool = false

@onready var marker : Sprite2D = $Marker
@onready var target : Sprite2D = $Target

@export var gun : Gun

var original_position := Vector2.ZERO

func _ready():
	Globals.current_bullets = Globals.max_bullets;
	
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

	# Allow horizontal, vertical, and diagonal movement
	var is_adjacent = delta_tile.length() <= Globals.TILE_SIZE * sqrt(2) and delta_tile.length() != 0
	# This condition ensures that the target tile is adjacent, including diagonals, but not the same tile

	if is_adjacent and viewport_rect.has_point(target_tile):
		marker.global_position = target_tile + Vector2(Globals.TILE_SIZE, Globals.TILE_SIZE) / 2
		marker.rotation = delta_tile.angle() -deg_to_rad(90.0)
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
		if is_adjacent and not moved:
			try_move_to_tile(target_tile)
		elif not is_adjacent and not action_performed:
			var shoot_dir = (target_tile - current_tile).normalized()
			action_performed = true
			shoot(shoot_dir)

func try_move_to_tile(target_tile: Vector2) -> void:
	var current_tile = get_current_tile()
	var delta = target_tile - current_tile

	# Allow diagonal movement and only check if it’s within one tile distance
	if delta.length() <= Globals.TILE_SIZE * sqrt(2) and delta.length() != 0:
		var viewport_rect = get_viewport().get_visible_rect()
		if viewport_rect.has_point(target_tile):
			position = get_tile_center(target_tile)
			moved = true
			end_turn()
	else:
		print("Invalid move. Must be to an adjacent tile.")

func shoot(direction: Vector2) -> void:
	print("Shooting in direction %s" % direction)
	
	if(Globals.current_bullets > 0):
		Globals.use_bullet.emit();
		Globals.current_bullets -= 1;
		gun.fire()
		end_turn()


func end_turn():
	if not action_performed and not moved:
		print("Action or movement required before ending turn!")
		return

	action_performed = false
	moved = false
	super.end_turn()

func get_tile_center(tile: Vector2) -> Vector2:
	return tile + Vector2(Globals.TILE_SIZE, Globals.TILE_SIZE) / 2

func get_current_tile() -> Vector2:
	return (position - Vector2(Globals.TILE_SIZE, Globals.TILE_SIZE) / 2).snapped(Vector2(Globals.TILE_SIZE, Globals.TILE_SIZE))
