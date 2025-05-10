extends Node2D

class_name Gun

var bullet_path = preload("res://scenes/bulltet.tscn")

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	$Sprite2D.flip_v = rotation > deg_to_rad(90) or rotation < deg_to_rad(-90)
	
func fire() -> void:
	var bullet : Bullet = bullet_path.instantiate()
	bullet.direction = rotation
	bullet.position = position
	add_child(bullet)
