extends Node2D
class_name FloatingBulletPickup

@export var initial_explode_speed: float = 150.0
@export var homing_speed: float = 100.0
@export var homing_delay: float = 0.25  # Time before homing starts
@export var acceleration: float = 300.0  # How quickly it speeds up toward the player

var target: Node2D
var velocity: Vector2
var homing: bool = false
var current_speed: float = 0.0
var time_elapsed := 0.0

func _ready():
	BackgroundMusic.pickup_sound.emit()
	var angle = randf() * TAU
	velocity = Vector2(cos(angle), sin(angle)) * initial_explode_speed
	current_speed = initial_explode_speed

func _process(delta):
	if not is_instance_valid(target):
		queue_free()
		return

	time_elapsed += delta

	if not homing and time_elapsed >= homing_delay:
		homing = true

	if homing:
		var to_player = target.global_position - global_position
		if to_player.length() < 8:
			if Globals.current_bullets < Globals.max_bullets:
				Globals.current_bullets += 1
				Globals.play_sound.emit('pickup');
				Globals.bullet_collected.emit()
			queue_free()
			return

		current_speed = min(current_speed + acceleration * delta, homing_speed)
		velocity = to_player.normalized() * current_speed

	global_position += velocity * delta
