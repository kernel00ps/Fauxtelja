extends AudioStreamPlayer2D

signal bullet_hit_sound()
signal death_sound()
signal pickup_sound()
signal no_bullets_sound()
signal slurp()
signal pljuca()
signal step()

func _ready() -> void:
	bullet_hit_sound.connect(play_bullet_hit_sound)
	death_sound.connect(play_death_sound)
	pickup_sound.connect(play_pickup_sound)
	no_bullets_sound.connect(play_no_bullets_sound)
	slurp.connect(play_slurp_sound)
	pljuca.connect(play_pljuca_sound)
	step.connect(play_step_sound)

func play_bullet_hit_sound() -> void:
	$ExplosionSound.play()

func play_death_sound() -> void:
	$DeathSound.play()

func play_pickup_sound() -> void:
	$PickupSound.play()
	
func play_no_bullets_sound() -> void:
	$NoBulletsSound.play()

func play_slurp_sound() -> void:
	var index = int(randf() * 3)
	if index == 0:
		$SlurpSound1.play()
	elif index == 1:
		$SlurpSound2.play()
	elif index == 2:
		$SlurpSound3.play()

func play_pljuca_sound() -> void:
	var index = int(randf() * 3)
	if index == 0:
		$PljucaSound1.play()
	elif index == 1:
		$PljucaSound2.play()
	elif index == 2:
		$PljucaSound3.play()

func play_step_sound() -> void:
	$StepSound.play()
