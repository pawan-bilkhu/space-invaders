extends Node

# Groups
const GROUP_LASER: StringName = "laser"
const GROUP_PROJECTILE: StringName = "projectile"
const GROUP_ASTEROID: StringName = "asteroid"
const GROUP_SPACESHIP: StringName = "spaceship"
const GROUP_ENEMY: StringName = "enemy"


# Signals

# Sprite PackedScenes
enum SPRITE_KEY {
	SHIP, 
	METEOR,
}
	
const SPRITE_SCENES = {
	SPRITE_KEY.SHIP : preload("res://space_ship/space_ship_sprite.tscn"),
	SPRITE_KEY.METEOR : preload("res://objects/asteroid/asteroid.tscn"),
}

# Explosion PackedScenes
enum EXPLOSION_KEY { 
	FIRE_EXPLOSION, 
	SMALL_EXPLOSION,
	MUZZLE_FLASH,
}

const EXPLOSION_SCENES = {
	EXPLOSION_KEY.FIRE_EXPLOSION : preload("res://objects/explosions/fire_explosion/fire_explosion.tscn"),
	EXPLOSION_KEY.SMALL_EXPLOSION : preload("res://objects/explosions/small_explosion/small_explosion.tscn"),
	EXPLOSION_KEY.MUZZLE_FLASH : preload("res://objects/muzzle_flash/muzzle_falsh.tscn"),
}

# Projectile PackedScenes
enum WEAPON_KEY {
	LIGHT_PROJECTILE,
	RICOCHET_PROJECTILE,
	HEAVY_PROJECTILE,
	ROCKET_PROJECTILE,
	BLUE_LASER,
	GREEN_LASER,
	WHITE_LASER,
}

const WEAPON_SCENES = {
	WEAPON_KEY.LIGHT_PROJECTILE : preload("res://projectiles/light_projectile/light_projectile.tscn"),
	WEAPON_KEY.RICOCHET_PROJECTILE : preload("res://projectiles/ricochet_projectile/ricochet_projectile.tscn"),
	WEAPON_KEY.HEAVY_PROJECTILE : preload("res://projectiles/heavy_projectile/heavy_projectile.tscn"),
	WEAPON_KEY.ROCKET_PROJECTILE : preload("res://projectiles/rocket_projectile/rocket_projectile.tscn"),
	WEAPON_KEY.BLUE_LASER : preload("res://lasers/blue_laser/blue_laser.tscn"),
	WEAPON_KEY.GREEN_LASER : preload("res://lasers/green_laser/green_laser.tscn"),
	WEAPON_KEY.WHITE_LASER : preload("res://lasers/white_laser/white_laser.tscn"),
}




func add_child_deferred(child_to_add) -> void:
	get_tree().root.add_child(child_to_add)


func call_add_child(child_to_add) -> void:
	call_deferred("add_child_deferred", child_to_add)


func create_projectile(key: WEAPON_KEY, _starting_position: Vector2, _velocity: Vector2, _rotation: float) -> void:
	var new_projectile = WEAPON_SCENES[key].instantiate()
	new_projectile.initialize(_starting_position, _velocity, _rotation)
	call_add_child(new_projectile)


func create_asteroid(_starting_position: Vector2, _torque, _force: Vector2, _health: int) -> void:
	var new_asteroid = SPRITE_SCENES[SPRITE_KEY.METEOR].instantiate()
	new_asteroid.position = _starting_position
	new_asteroid.initial_torque = _torque
	new_asteroid.initial_force = _force
	new_asteroid.health = _health
	call_add_child(new_asteroid)


func create_laser_emitter(key: WEAPON_KEY, _starting_position: Vector2, node_group: Node) -> void:
	var new_laser_emitter = WEAPON_SCENES[key].instantiate()
	new_laser_emitter.position = _starting_position
	node_group.add_child(new_laser_emitter)


func create_space_ship(_starting_position: Vector2) -> void:
	var new_space_ship = SPRITE_SCENES[SPRITE_KEY.SHIP].instantiate()
	new_space_ship.position = _starting_position
	call_add_child(new_space_ship)


func create_explosion(key: EXPLOSION_KEY, _starting_position: Vector2, _scale_factor: Vector2) -> void:
	var new_explosion = EXPLOSION_SCENES[key].instantiate()
	new_explosion.position = _starting_position
	new_explosion.scale_factor = _scale_factor
	call_add_child(new_explosion)


func create_muzzle_flash(_starting_position: Vector2, _scale_factor: Vector2, node_group: Node) -> void:
	var new_muzzle_flash = EXPLOSION_SCENES[EXPLOSION_KEY.MUZZLE_FLASH].instantiate()
	new_muzzle_flash.position = _starting_position
	new_muzzle_flash.scale_factor = _scale_factor
	node_group.add_child(new_muzzle_flash)
