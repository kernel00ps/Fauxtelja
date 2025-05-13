extends Area2D

class_name Pljuca

@export var pljuca_effect: PackedScene 
@onready var sprite = $Sprite2D
@onready var raycast: RayCast2D = $RayCast2D

var direction: Vector2 = Vector2.ZERO
var speed: float = 400.0

func _ready():
	connect("body_entered", _on_collision)
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
	if body is Player:
		_explode(body)
		queue_free()

func _explode(player : Player) -> void:
	var explosion = pljuca_effect.instantiate()
	explosion.position = position
	explosion.emitting = false
	explosion.one_shot = true
	explosion.emitting = true
	
	player.die()
	get_parent().add_child(explosion)
	explosion.finished.connect(OnFinishedParticle.bind(explosion))

func OnFinishedParticle(explosion):
	remove_child(explosion)
	explosion.queue_free()
