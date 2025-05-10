extends CanvasLayer

@onready var turn_label : RichTextLabel = $TurnLabel

func _ready() -> void:
	TurnManager.connect("turn_changed", _on_turn_changed)
	_on_turn_changed(TurnManager.current_state)  

func _on_turn_changed(state):
	$TurnLabel.text = "Turn %d – %s" % [
		TurnManager.current_turn_number,
		 "Player" if state == TurnManager.TurnState.PLAYER else "Enemy"
	]
