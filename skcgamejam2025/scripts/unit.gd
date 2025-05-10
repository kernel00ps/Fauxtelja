extends CharacterBody2D
class_name Unit

var can_act: bool = false

func start_turn():
	can_act = true
	print("%s started turn" % self.name)

func end_turn():
	can_act = false
	TurnManager.unit_finished_turn()
