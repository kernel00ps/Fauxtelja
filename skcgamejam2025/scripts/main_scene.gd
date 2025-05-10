extends Node2D

func _ready():
	TurnManager.player_units = [$Player]
	TurnManager.enemy_units.clear()
	var enemies_node = $Enemies
	
	for enemy in enemies_node.get_children():
		if enemy is EnemyUnit:
			TurnManager.enemy_units.append(enemy)
	TurnManager.start_turn()
