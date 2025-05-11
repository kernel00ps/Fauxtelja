extends Control

func _ready():
	get_tree().current_scene = self

func _on_play_button_pressed() -> void:
	LevelManager.load_level(LevelManager.current_level_index)

func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/credits_menu.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
