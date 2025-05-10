extends CharacterBody2D
class_name Unit

var can_act: bool = false

func start_turn():
	can_act = true
	print("%s started turn" % self.name)

func end_turn():
	can_act = false
	TurnManager.unit_finished_turn()

func get_current_tile() -> Vector2:
	return (position - Vector2(Globals.TILE_SIZE, Globals.TILE_SIZE) / 2).snapped(Vector2(Globals.TILE_SIZE, Globals.TILE_SIZE))
