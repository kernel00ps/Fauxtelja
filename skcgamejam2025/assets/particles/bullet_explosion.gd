extends GPUParticles2D

func _ready() -> void:
	finished.connect(_on_particles_finished)

func _on_particles_finished() -> void:
	print("SELF-FREEING PARTICLES")
	stop()
	queue_free()

func stop() -> void:
	emitting = false
	one_shot = true
	emitting = true
	emitting = false
