extends RigidBody2D

@export var animation_player: AnimationPlayer
@export var sprite_2d: Sprite2D
@export var scale_factor: Vector2 = Vector2.ONE
@export var initial_force: Vector2 = Vector2.ZERO
@export var rotation_rate: float = 0
@export var health: int = 0
var is_dead: bool = false


func _ready() -> void:
	apply_central_impulse(initial_force)
	apply_scale(scale_factor)


func _physics_process(delta: float) -> void:
	rotation += rotation_rate * delta


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


func destroy() -> void:
	if is_dead:
		return
	is_dead = true
	GameManager.create_explosion(GameManager.EXPLOSION_KEY.FIRE_EXPLOSION, global_position, 10*scale_factor)
	queue_free()


