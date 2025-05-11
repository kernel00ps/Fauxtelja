extends Node

var levels: Array[String] = [
	"res://levels/level_1.tscn",
	"res://levels/level_2.tscn",
	"res://levels/level_3.tscn",
	"res://levels/level_4.tscn",
	"res://levels/level_5.tscn"
]

var main_menu: String = "res://scenes/main_menu.tscn"

var current_level_index: int = 0

func load_level(index: int):
	var level_scene = null
	if index >= 0 and index < levels.size():
		level_scene = load(levels[index]) as PackedScene
	else:
		level_scene = load(main_menu) as PackedScene
		current_level_index = 0

	var level_instance = level_scene.instantiate()

	# Delay the switch using call_deferred
	call_deferred("_switch_scene", level_instance)

func _switch_scene(level_instance: Node):
	var current = get_tree().current_scene
	if current != null:
		current.queue_free()
	
	get_tree().root.add_child(level_instance)
	get_tree().current_scene = level_instance

func go_to_next_level():
	current_level_index += 1
	load_level(current_level_index)
