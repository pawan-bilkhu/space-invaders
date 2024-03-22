extends Node


const GROUP_LASER: StringName = "laser"

enum SPRITE_KEY { SHIP, PROJECTILE, METEOR, EXPLOSION }
const SPRITES = {
	SPRITE_KEY.SHIP : preload("res://space_ship/space_ship_sprite.tscn"),
	SPRITE_KEY.PROJECTILE : preload("res://projectiles/laser.tscn"),
	SPRITE_KEY.METEOR : preload("res://objects/meteors/meteor.tscn"),
	SPRITE_KEY.EXPLOSION : preload("res://objects/explosions/explosion.tscn")
	
}


func add_child_deferred(child_to_add) -> void:
	get_tree().root.add_child(child_to_add)


func call_add_child(child_to_add) -> void:
	call_deferred("add_child_deferred", child_to_add)


func create_projectile(_starting_position: Vector2, _velocity: Vector2, _rotation: float) -> void:
	var new_projectile = SPRITES[SPRITE_KEY.PROJECTILE].instantiate()
	new_projectile.initialize(_starting_position, _velocity, _rotation)
	call_add_child(new_projectile)


func create_meteor(_starting_position: Vector2, _force: Vector2, _scale_factor: Vector2, _health: int) -> void:
	var new_meteor = SPRITES[SPRITE_KEY.METEOR].instantiate()
	new_meteor.position = _starting_position
	new_meteor.initial_force = _force
	new_meteor.scale_factor = _scale_factor
	new_meteor.health = _health
	call_add_child(new_meteor)


func create_space_ship(_starting_position: Vector2) -> void:
	var new_space_ship = SPRITES[SPRITE_KEY.SHIP].instantiate()
	new_space_ship.position = _starting_position
	call_add_child(new_space_ship)


func create_explosion(_starting_position: Vector2, _scale_factor: Vector2, _animation: StringName) -> void:
	var new_explosion = SPRITES[SPRITE_KEY.EXPLOSION].instantiate()
	new_explosion.position = _starting_position
	new_explosion.scale_factor = _scale_factor
	new_explosion.animation = _animation
	call_add_child(new_explosion)
