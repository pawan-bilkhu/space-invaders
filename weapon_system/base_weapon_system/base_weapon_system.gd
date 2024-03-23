extends Node2D
class_name BaseWeaponSystem

@export var weapon_group: Node2D
@export var shoot_interval_timer: Timer 
@export var initial_velocity: Vector2 = Vector2(0,-1)
@export var interval_duration: float = 0
@export var initial_rotation: float = 0
@export var reference_sprite_2d: AnimatedSprite2D

var can_shoot: bool = true
var weapon_index: int = 0
var distance_to_mouse: Vector2 = Vector2.ZERO

var weapon_type: Array[GameManager.WEAPON_KEY] = [
	GameManager.WEAPON_KEY.GREEN_LASER, 
	GameManager.WEAPON_KEY.RED_LASER,
	GameManager.WEAPON_KEY.ROCKET,
	]

func _ready() -> void:
	reference_sprite_2d.hide()

func _physics_process(delta: float) -> void:
	select_weapon_type()
	on_shoot()

func select_weapon_type() -> void:
	if Input.is_action_just_pressed("select"):
		weapon_index += 1
		weapon_index = weapon_index % weapon_type.size()


func on_shoot() -> void:
	if not can_shoot:
		return
	if Input.is_action_pressed("shoot"):
		can_shoot = false
		for weapon in weapon_group.get_children():
			GameManager.create_projectile(weapon_type[weapon_index], weapon.global_position, initial_velocity, initial_rotation)
			break
		shoot_interval_timer.start(interval_duration)
		



func _on_shoot_interval_timer_timeout() -> void:
	can_shoot = true
