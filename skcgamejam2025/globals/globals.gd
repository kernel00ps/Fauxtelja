extends Node

const TILE_SIZE: int = 16
const BULLET_SPEED: int = 1000

const BASE_HEALTH_ENEMY: int = 1
const BASE_HEALTH_RANGE: int = 1
const BASE_HEALTH_MELEE: int = 1
const BASE_HEALTH_EXPLOSION: int = 1

var max_bullets: int = 3;
var current_bullets: int

signal use_bullet()
signal died()
