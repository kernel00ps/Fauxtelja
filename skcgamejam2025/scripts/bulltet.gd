extends Area2D

class_name Bullet

@export var explosion_effect: PackedScene  # Explosive effect scene to be instanced
@onready var sprite = $Sprite2D

var direction: Vector2 = Vector2.ZERO  # Bullet direction vector
var speed: float = 400.0  # Bullet speed

func _ready():
	connect("body_entered", _on_collision)

func _process(delta: float) -> void:
	position += direction * speed * delta

func _on_collision(body: Node) -> void:
	if body is EnemyUnit:
		_explode(body)
		queue_free()

func _explode(enemy : EnemyUnit) -> void:
	var explosion = explosion_effect.instantiate()
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
