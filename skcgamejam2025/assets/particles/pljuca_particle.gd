extends GPUParticles2D

@export var particle_texture: Texture 
@export var size_min: float = 0.5
@export var size_max: float = 1.5
@export var lifetime_min: float = 0.5
@export var lifetime_max: float = 1.5

func _ready():
	one_shot = true
	emitting = false
	set_particles_properties()
	
func set_particles_properties():
	
	var material = ShaderMaterial.new()
	material.shader = preload("res://assets/shaders/pljuca.gdshader")
	#material.shader.set_shader_param("texture", texture)

	process_material = material
	lifetime = lifetime_min  # Set min and max lifetime for randomness
