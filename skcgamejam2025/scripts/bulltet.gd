extends Area2D

class_name Bullet

@export var explosion_effect: PackedScene 
@export var wood_explosion_effect: PackedScene
@onready var sprite = $Sprite2D

var direction: Vector2 = Vector2.ZERO
var speed: float = 400.0

func _ready():
	connect("body_entered", _on_collision)
	connect("area_entered", _on_collision)

func _process(delta: float) -> void:
	position += direction * speed * delta

func _on_collision(body: Node) -> void:
	if body is EnemyUnit:
		_explode(body)
		queue_free()
	elif body is BulletBox or body.is_in_group("shootable"):
		body.hit_by_bullet()
		queue_free()

func _explode(enemy : EnemyUnit) -> void:
	
	var explosion;
	
	if enemy is AfkUnit:
		explosion = explosion_effect.instantiate()
	else:
		explosion = explosion_effect.instantiate()
	
	explosion.position = position
	explosion.emitting = false
	explosion.one_shot = true
	explosion.emitting = true
	
	enemy.die()
	
	get_parent().add_child(explosion)

	explosion.finished.connect( OnFinishedParticle.bind( explosion ) )


func OnFinishedParticle( explosion ):
	remove_child( explosion )
	explosion.queue_free()
