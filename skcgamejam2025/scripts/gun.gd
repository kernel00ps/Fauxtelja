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
	# Convert the gun's rotation to a direction (Vector2)
	bullet.direction = Vector2(cos(pivot.rotation), sin(pivot.rotation))  # Direction based on angle

	# Fire from the gun barrel's tip (position of the sprite + any offset for the barrel)
	bullet.position = sprite.get_global_position()

	# Add the bullet to the scene (parent it to the current scene)
	get_tree().root.add_child(bullet)
