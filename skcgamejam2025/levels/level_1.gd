extends BaseLevel


func _ready() -> void:
	initiate_turn_manager()
	get_used_rect_for_layer($TileMapLayer)
	Globals.max_bullets = 5
	Globals.current_bullets = 5
	$UI.clear_bullet_sprites()
	$UI.init_bullet_sprites()
