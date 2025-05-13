extends Area2D

class_name Bullet

@export var explosion_effect: PackedScene 
@export var wood_explosion_effect: PackedScene
@onready var sprite = $Sprite2D
@onready var raycast: RayCast2D = $RayCast2D

var direction: Vector2 = Vector2.ZERO
var speed: float = 400.0

func _ready():
	# fallback
	connect("body_entered", _on_collision)
	connect("area_entered", _on_collision)
	raycast.enabled = true

func _physics_process(delta: float) -> void:
	var travel = direction.normalized() * speed * delta
	raycast.target_position = travel
	raycast.force_raycast_update()

	if raycast.is_colliding():
		var collider = raycast.get_collider()
		_handle_hit(collider)
		return
	# no colission = move normally
	position += travel
	
#func _process(delta: float) -> void:
#	position += direction * speed * delta

func _on_collision(body: Node) -> void:
	_handle_hit(body)
	
func _handle_hit(body: Node) -> void:	
	if body is EnemyUnit:
		_explode(body)
		queue_free()
	elif body is BulletBox or body.is_in_group("shootable"):
		body.hit_by_bullet()
		queue_free()

func _explode(enemy : EnemyUnit) -> void:
	
	var gpu_particles: GPUParticles2D
	var explosion = explosion_effect.instantiate()

	#if not enemy.is_evil:
		#explosion.self_modulate = Color(0.95, 0.95, 0.95, 1.0)
	
	explosion.position = position
	explosion.emitting = false
	explosion.one_shot = true
	explosion.emitting = true
	
	enemy.die()
	
	BackgroundMusic.bullet_hit_sound.emit()
	get_parent().add_child(explosion)
	explosion.finished.connect(OnFinishedParticle.bind(explosion))

func OnFinishedParticle( explosion ):
	remove_child(explosion)
	explosion.queue_free()
