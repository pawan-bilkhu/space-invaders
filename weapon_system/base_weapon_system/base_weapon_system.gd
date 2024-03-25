extends Node2D
class_name BaseWeaponSystem

@export var projectile_group: Node2D
@export var laser_group: Node2D
@export var shoot_interval_timer: Timer 
@export var initial_velocity: Vector2 = Vector2(0,-1)
@export var interval_duration: float = 0
@export var initial_rotation: float = 0
@export var reference_sprite_2d: AnimatedSprite2D

var can_shoot: bool = true
var projectile_index: int = 0
var laser_index: int = 0
var distance_to_mouse: Vector2 = Vector2.ZERO

var projectile_type: Array[GameManager.WEAPON_KEY] = [
	GameManager.WEAPON_KEY.LIGHT_PROJECTILE, 
	GameManager.WEAPON_KEY.RICOCHET_PROJECTILE,
	GameManager.WEAPON_KEY.HEAVY_PROJECTILE,
	GameManager.WEAPON_KEY.ROCKET_PROJECTILE,
	]


var laser_type: Array[GameManager.WEAPON_KEY] = [
	GameManager.WEAPON_KEY.BLUE_LASER,
]


func _ready() -> void:
	reference_sprite_2d.hide()


func _physics_process(delta: float) -> void:
	select_weapon_type()
	on_shoot()


func select_weapon_type() -> void:
	if Input.is_action_just_pressed("projectile_weapon_select"):
		projectile_index += 1
		projectile_index = projectile_index % projectile_type.size()
	if Input.is_action_just_pressed("laser_weapon_select"):
		var laser = laser_group.get_children()
		laser[laser_index].hide()
		laser_index += 1
		laser_index = laser_index % laser_type.size()


func on_shoot() -> void:
	var laser = laser_group.get_children()
	if Input.is_action_pressed("shoot_alternate"):
			laser[0].set_casting(true)
	if Input.is_action_just_released("shoot_alternate"):
			laser[0].set_casting(false)
	if not can_shoot:
		return
	if Input.is_action_pressed("shoot"):
		can_shoot = false
		for weapon in projectile_group.get_children():
			GameManager.create_projectile(projectile_type[projectile_index], weapon.global_position, initial_velocity, initial_rotation)
		shoot_interval_timer.start(interval_duration)


func _on_shoot_interval_timer_timeout() -> void:
	can_shoot = true
