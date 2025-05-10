extends Node2D
class_name Gun

var bullet_path = preload("res://scenes/bulltet.tscn")

@onready var pivot: Sprite2D = $GunGolder
@onready var sprite: Sprite2D = $GunGolder/Sprite2D

func _physics_process(delta: float) -> void:
	var to_mouse = get_global_mouse_position() - pivot.global_position
	pivot.rotation = to_mouse.angle()
	sprite.flip_v = pivot.rotation > deg_to_rad(90) or pivot.rotation < deg_to_rad(-90)

func fire() -> void:
	var bullet: Bullet = bullet_path.instantiate()
	bullet.direction = pivot.rotation
	bullet.position = sprite.get_global_position()  # Fire from the gun barrel's tip
	get_tree().current_scene.add_child(bullet)  # Don't parent it to the gun!
