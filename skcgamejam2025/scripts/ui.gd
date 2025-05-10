extends CanvasLayer

@onready var turn_label : RichTextLabel = $TurnLabel

var bullet_icons = []

func _ready() -> void:
	TurnManager.connect("turn_changed", _on_turn_changed)
	Globals.connect("use_bullet", use_bullet_sprite);
	_on_turn_changed(TurnManager.current_state)  
	init_bullet_sprites()

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

func init_bullet_sprites():
	var bullet_container = $"Bullet Counter";
	for n in range(Globals.max_bullets):
		var bull = load("res://scenes/ui_bullet_icon.tscn").instantiate()
		bullet_container.add_child(bull)
		bullet_icons.append(bull);
	return

func use_bullet_sprite():
	bullet_icons.get(Globals.current_bullets-1).set_empty();
	return

func reload_bullet_sprite():
	bullet_icons.get(Globals.current_bullets-1).set_full();
	return
