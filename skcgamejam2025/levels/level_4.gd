extends BaseLevel

func _ready() -> void:
	initiate_turn_manager()
	#get_used_rect_for_layer($TileMapLayer)
	Globals.max_bullets = 2
	Globals.current_bullets = 2
	Globals.max_evil_sofas = 4
	Globals.current_evil_sofas = 4
	$UI.clear_bullet_sprites()
	$UI.init_bullet_sprites()
	$UI.init_evil_sofa_sprites()
