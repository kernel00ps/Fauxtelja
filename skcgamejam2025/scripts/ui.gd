extends CanvasLayer

@onready var turn_label : RichTextLabel = $TurnLabel

var bullet_icons = []
var sofa_icons = []

func _ready() -> void:
	TurnManager.connect("turn_changed", _on_turn_changed);
	Globals.connect("use_bullet", use_bullet_sprite);
	Globals.connect("bullet_collected", reload_bullet_sprite);
	Globals.connect("kill_evil_sofa", use_evil_sofa_sprite);
	_on_turn_changed(TurnManager.current_state)  
	#init_bullet_sprites()
	#init_evil_sofa_sprites()

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
	
func clear_bullet_sprites() -> void:
	var bullet_container = $"Bullet Counter";
	for child in bullet_container.get_children():
		bullet_container.remove_child(child)
	bullet_icons.clear()

func init_evil_sofa_sprites():
	var sofa_container = $"Sofa Counter";
	for n in range(Globals.max_evil_sofas):
		var sofa = load("res://scenes/ui_sofa_icon.tscn").instantiate()
		sofa_container.add_child(sofa)
		sofa_icons.append(sofa);
	return

func clear_evil_sofa_sprites() -> void:
	var sofa_container = $"Sofa Counter";
	for child in sofa_container.get_children():
		sofa_container.remove_child(child)
	sofa_icons.clear()

func use_evil_sofa_sprite():
	sofa_icons.get(Globals.current_evil_sofas).set_empty();
	return

func use_bullet_sprite():
	bullet_icons.get(Globals.current_bullets-1).set_empty();
	return

func reload_bullet_sprite():
	if Globals.current_bullets > Globals.max_bullets:
		return
	var index = Globals.current_bullets - 1
	if index >= 0 and index < bullet_icons.size():
		bullet_icons.get(index).set_full()
