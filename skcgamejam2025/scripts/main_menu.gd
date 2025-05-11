extends Control

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_scene.tscn")

func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/credits_menu.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_instructions_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/instructions_menu.tscn")
