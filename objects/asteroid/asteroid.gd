extends RigidBody2D

@export var animation_player: AnimationPlayer
@export var sprite_2d: Sprite2D
@export var scale_factor: Vector2 = Vector2.ONE
@export var initial_force: Vector2 = Vector2.ZERO
@export var initial_torque: float
@export var health: int = 0
@export var cpu_particles_2d: CPUParticles2D


var is_dead: bool = false


func _ready() -> void:
	cpu_particles_2d.emitting = false
	apply_central_impulse(initial_force)
	apply_torque_impulse(initial_torque)
	apply_scale(scale_factor)


func _physics_process(delta: float) -> void:
	cpu_particles_2d.global_rotation = 0



func get_health() -> int:
	return health


func set_health(value: int) -> void:
	health = value


func apply_damage(damage_amount: int) -> void:
	set_health(get_health() - damage_amount)
	animation_player.play("damaged")
	on_health_zero()


func on_health_zero() -> void:
	if health > 0:
		return
	destroy()


func emit_particles(_direction: Vector2, color_ramp: Gradient) -> void:
	cpu_particles_2d.emitting = true
	cpu_particles_2d.direction = _direction
	cpu_particles_2d.set_color_ramp(color_ramp)


func destroy() -> void:
	if is_dead:
		return
	is_dead = true
	GameManager.create_explosion(GameManager.EXPLOSION_KEY.FIRE_EXPLOSION, global_position, 10*scale_factor)
	queue_free()



func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group(GameManager.GROUP_LASER):
		cpu_particles_2d.color_initial_ramp
		cpu_particles_2d.emitting = false
