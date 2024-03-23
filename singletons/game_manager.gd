extends Node

# Groups
const GROUP_BASE_LASER: StringName = "base_laser"
const GROUP_RICOCHET_LASER: StringName = "ricochet_laser"
const GROUP_ROCKET: StringName = "rocket"
const GROUP_METEOR: StringName = "meteor"
const GROUP_SPACESHIP: StringName = "spaceship"
const GROUP_HITSCAN: StringName = "hitscan"


# Signals

# Sprite PackedScenes
enum SPRITE_KEY {
	SHIP, 
	METEOR,
	}
	
const SPRITE_SCENES = {
	SPRITE_KEY.SHIP : preload("res://space_ship/space_ship_sprite.tscn"),
	SPRITE_KEY.METEOR : preload("res://objects/meteors/meteor.tscn"),
}

# Explosion PackedScenes
enum EXPLOSION_KEY { 
	FIRE_EXPLOSION, 
	SMALL_EXPLOSION,
	}

const EXPLOSION_SCENES = {
	EXPLOSION_KEY.FIRE_EXPLOSION : preload("res://objects/explosions/fire_explosion/fire_explosion.tscn"),
	EXPLOSION_KEY.SMALL_EXPLOSION : preload("res://objects/explosions/small_explosion/small_explosion.tscn"),
}

# Projectile PackedScenes
enum WEAPON_KEY {
	GREEN_LASER,
	RED_LASER,
	YELLOW_LASER,
	BLUE_LASER,
	PINK_LASER,
	ROCKET,
}

const WEAPON_SCENES = {
	WEAPON_KEY.GREEN_LASER : preload("res://projectiles/green_laser/green_laser.tscn"),
	WEAPON_KEY.RED_LASER : preload("res://projectiles/red_laser/red_laser.tscn"),
	WEAPON_KEY.ROCKET : preload("res://projectiles/rocket/rocket.tscn"),
	WEAPON_KEY.PINK_LASER : preload("res://hit_scan/pink_laser/pink_laser.tscn")
}




func add_child_deferred(child_to_add) -> void:
	get_tree().root.add_child(child_to_add)


func call_add_child(child_to_add) -> void:
	call_deferred("add_child_deferred", child_to_add)


func create_projectile(key: WEAPON_KEY, _starting_position: Vector2, _velocity: Vector2, _rotation: float) -> void:
	var new_projectile = WEAPON_SCENES[key].instantiate()
	new_projectile.initialize(_starting_position, _velocity, _rotation)
	call_add_child(new_projectile)


func create_hitscan(key: WEAPON_KEY) -> void:
	var new_hitscan = WEAPON_SCENES[key].instantiate()
	call_add_child(new_hitscan)


func create_meteor(_starting_position: Vector2, _force: Vector2, _health: int) -> void:
	var new_meteor = SPRITE_SCENES[SPRITE_KEY.METEOR].instantiate()
	new_meteor.position = _starting_position
	new_meteor.initial_force = _force
	new_meteor.health = _health
	call_add_child(new_meteor)


func create_space_ship(_starting_position: Vector2) -> void:
	var new_space_ship = SPRITE_SCENES[SPRITE_KEY.SHIP].instantiate()
	new_space_ship.position = _starting_position
	call_add_child(new_space_ship)


func create_explosion(key: EXPLOSION_KEY, _starting_position: Vector2, _scale_factor: Vector2) -> void:
	var new_explosion = EXPLOSION_SCENES[key].instantiate()
	new_explosion.position = _starting_position
	new_explosion.scale_factor = _scale_factor
	call_add_child(new_explosion)

