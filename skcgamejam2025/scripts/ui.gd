extends CanvasLayer

@onready var turn_label : RichTextLabel = $TurnLabel

func _ready() -> void:
	TurnManager.connect("turn_changed", _on_turn_changed)
	_on_turn_changed(TurnManager.current_state)  

func _on_turn_changed(state):
	var label_text := ""
	match state:
		TurnManager.TurnState.PLAYER:
			label_text = "Player"
		TurnManager.TurnState.ENEMY:
			label_text = "Enemy"
		TurnManager.TurnState.WAITING:
			label_text = "Waiting ..."

	$TurnLabel.text = "Turn %d – %s" % [
		TurnManager.current_turn_number,
		label_text
	]
