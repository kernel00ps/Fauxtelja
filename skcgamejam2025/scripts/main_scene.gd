extends Node2D

func _ready():
	TurnManager.player_units = [$Player]
	TurnManager.enemy_units.clear()
	var enemies_node = $Enemies
	
	Globals.connect("play_sound", play_sound);
	
	for enemy in enemies_node.get_children():
		if enemy is EnemyUnit:
			TurnManager.enemy_units.append(enemy)
	TurnManager.start_turn()

func play_sound(sound_name):
	print('Trying to play sound!' + sound_name);
	match(sound_name):
		"step":
			$soundplayer_step.play();
			return;
		"shoot":
			$soundplayer_shoot.play();
			return;
		"death":
			$soundplayer_death.play();
			return;
		"spit":
			$soundplayer_spit.play();
			return;
		"slurp":
			$soundplayer_slurp.play();
			return;
		"nobullets":
			$soundplayer_nobullets.play();
			return;
		"pickup":
			$soundplayer_pickup.play();
			return;
	return;
