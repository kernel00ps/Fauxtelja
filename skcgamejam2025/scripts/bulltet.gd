extends CharacterBody2D

class_name Bullet

var direction = 0.0

func _physics_process(delta: float) -> void:
	velocity = Vector2(Globals.BULLET_SPEED, 0).rotated(direction)
	move_and_slide()

func _ready() -> void:
	await get_tree().create_timer(5.0).timeout
	queue_free()
