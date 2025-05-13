extends BaseLevel

func _ready() -> void:
	initiate_turn_manager()
	#get_used_rect_for_layer($TileMapLayer)
	Globals.max_bullets = 5
	Globals.current_bullets = 5
	
	var evil_sofa_num: int = 0
	
	for enemy in $Enemies.get_children():
		if enemy is EnemyUnit and enemy.is_evil:
			evil_sofa_num += 1
	
	Globals.max_evil_sofas = evil_sofa_num
	Globals.current_evil_sofas = evil_sofa_num
	$UI.clear_bullet_sprites()
	$UI.init_bullet_sprites()
	$UI.clear_evil_sofa_sprites()
	$UI.init_evil_sofa_sprites()
