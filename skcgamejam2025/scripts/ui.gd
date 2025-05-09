extends CanvasLayer

@onready var turn_label : RichTextLabel = $TurnLabel

func _ready() -> void:
	TurnManager.connect("turn_changed", _on_turn_changed)
	_on_turn_changed(TurnManager.current_state)  

func _on_turn_changed(state):
	match state:
		TurnManager.TurnState.PLAYER:
			turn_label.text = "Player Turn %d" % TurnManager.current_turn_number
		TurnManager.TurnState.ENEMY:
			turn_label.text = "Enemy Turn %d" % TurnManager.current_turn_number
		TurnManager.TurnState.WAITING:
			turn_label.text = "Waiting... %d" % TurnManager.current_turn_number
