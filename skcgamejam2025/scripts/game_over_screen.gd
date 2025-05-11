extends CanvasLayer

func _process(delta: float) -> void:
	$Sprite2D.position.y += 1

@onready var restart_button = $RestartButton
@onready var menu_button = $MenuButton

func _ready():
	restart_button.pressed.connect(_on_restart_pressed)
	menu_button.pressed.connect(_on_menu_pressed)

func show_death_ui():
	visible = true

func _on_restart_pressed():
	get_tree().reload_current_scene()

func _on_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/main_scene.tscn")
