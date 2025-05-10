extends Node2D

func _ready():
	TurnManager.player_units = [$Player]
	TurnManager.enemy_units = [$Enemies/EnemyUnit, $Enemies/RangeEnemyUnit]
	TurnManager.start_turn()
