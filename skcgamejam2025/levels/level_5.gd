extends BaseLevel

func _ready() -> void:
	initiate_turn_manager()
	#get_used_rect_for_layer($TileMapLayer)
	Globals.max_bullets = 3
	Globals.current_bullets = 3
	Globals.max_evil_sofas = 10
	Globals.current_evil_sofas = 10
	$UI.clear_bullet_sprites()
	$UI.init_bullet_sprites()
	$UI.init_evil_sofa_sprites()
