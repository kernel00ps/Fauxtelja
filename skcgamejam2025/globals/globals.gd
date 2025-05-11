extends Node

const TILE_SIZE: int = 16
const BULLET_SPEED: int = 1000

const BASE_HEALTH_ENEMY: int = 1
const BASE_HEALTH_RANGE: int = 1
const BASE_HEALTH_MELEE: int = 1
const BASE_HEALTH_EXPLOSION: int = 1

var max_bullets: int = 1;
var current_bullets: int
var player : Player = null

var max_evil_sofas: int = 2;
var current_evil_sofas: int

signal use_bullet()
signal bullet_collected()
signal kill_evil_sofa()
signal died()

signal play_sound(sound_name)
