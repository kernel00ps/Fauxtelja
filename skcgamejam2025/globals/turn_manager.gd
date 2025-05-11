extends Node

enum TurnState { PLAYER, ENEMY, WAITING }
var current_state: TurnState = TurnState.PLAYER

var player_units: Array[Node] = []
var enemy_units: Array[Node] = []

var current_unit_index: int = 0
var turn_in_progress: bool = false
var turns_stopped : bool = false
var current_turn_number: int = 1

signal turn_changed(current_state)

func update_turn_label():
	emit_signal("turn_changed", current_state)

func start_turn():
	
	if turns_stopped:
		return
	
	turn_in_progress = true
	current_unit_index = 0
	cleanup_invalid_units()

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
				var unit = enemy_units[current_unit_index]
				if is_instance_valid(unit):
					unit.start_turn()
				else:
					unit_finished_turn()  

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
	await get_tree().process_frame
	start_turn()


func cleanup_invalid_units():
	player_units = player_units.filter(is_instance_valid)
	enemy_units = enemy_units.filter(is_instance_valid)

func stop_turns() -> void:
	turn_in_progress = false
	turns_stopped = true
	for node : Player in player_units:
		node.can_act = false
	for node : EnemyUnit in enemy_units:
		node.can_act = false
