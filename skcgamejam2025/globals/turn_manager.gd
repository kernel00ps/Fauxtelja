extends Node

enum TurnState { PLAYER, ENEMY, WAITING }
var current_state: TurnState = TurnState.PLAYER

var player_units: Array[Node] = []
var enemy_units: Array[Node] = []

var current_unit_index: int = 0
var turn_in_progress: bool = false
var current_turn_number: int = 1

signal turn_changed(current_state)

func update_turn_label():
	emit_signal("turn_changed", current_state)

func start_turn():
	turn_in_progress = true
	current_unit_index = 0
	match current_state:
		TurnState.PLAYER:
			if player_units.is_empty():
				end_turn()
			else:
				player_units[current_unit_index].start_turn()
		TurnState.ENEMY:
			if enemy_units.is_empty():
				end_turn()
			else:
				enemy_units[current_unit_index].start_turn()
	emit_signal("turn_changed", current_state)
	
func unit_finished_turn():
	current_unit_index += 1
	var units = player_units if current_state == TurnState.PLAYER else enemy_units

	if current_unit_index < units.size():
		units[current_unit_index].start_turn()
	else:
		end_turn()

func end_turn():
	if current_state == TurnState.ENEMY:
		current_turn_number += 1
		print("Turn %d complete" % current_turn_number)

	current_state = TurnState.ENEMY if current_state == TurnState.PLAYER else TurnState.PLAYER
	start_turn()
