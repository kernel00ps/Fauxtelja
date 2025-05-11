extends EnemyUnit
class_name AfkUnit

func _ready() -> void:
	is_evil = false

func start_turn():
	can_act = true;
	end_turn();
	return

func die() -> void:
	if TurnManager.enemy_units.has(self):
		var was_my_turn = (TurnManager.enemy_units[TurnManager.current_unit_index] == self)
		TurnManager.enemy_units.erase(self)
		queue_free()
		if was_my_turn:
			TurnManager.unit_finished_turn()
