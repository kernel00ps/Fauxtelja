extends Area2D
class_name BulletBox

@export var bullets_to_give: int = 3
@export var bullet_pickup_scene: PackedScene
@export var break_effect: PackedScene

var broken := false

func _ready():
	add_to_group("shootable")

func hit_by_bullet():
	if broken:
		return
	broken = true
	
	if break_effect:
		var fx = break_effect.instantiate()
		fx.position = position
		fx.emitting = false
		fx.one_shot = true
		fx.emitting = true
		
		get_parent().add_child(fx)

		fx.finished.connect( OnFinishedParticle.bind( fx ) )

	drop_bullets()
	queue_free()
	
func OnFinishedParticle( explosion ):
	remove_child( explosion )
	explosion.queue_free()

func drop_bullets():
	var player = Globals.player
	if not player:
		return

	for i in range(bullets_to_give):
		var pickup = bullet_pickup_scene.instantiate()
		pickup.global_position = global_position
		pickup.target = player
		get_parent().add_child(pickup)

func get_current_tile() -> Vector2:
	return (position - Vector2(Globals.TILE_SIZE, Globals.TILE_SIZE) / 2).snapped(Vector2(Globals.TILE_SIZE, Globals.TILE_SIZE))
