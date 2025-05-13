extends EnemyUnit
class_name AfkUnit

func _ready() -> void:
	is_evil = false

func start_turn():
	can_act = true;
	end_turn();
	return
