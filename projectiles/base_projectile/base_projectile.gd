extends CharacterBody2D
class_name BaseProjectile

@export var lifespan: float = 0
@export var health: int = 0
@export var damage_amount: int = 0
@export var speed: float = 200
@export var lifespan_timer: Timer
@export var scale_factor: Vector2 = Vector2.ONE
var is_dead: bool = false

func _ready() -> void:
	apply_scale(scale_factor)
	lifespan_timer.start(lifespan)

func _physics_process(delta: float) -> void:
	move_and_slide()


func initialize(_starting_position: Vector2, _velocity: Vector2, _rotation) -> void:
	global_position = _starting_position
	velocity = _velocity
	velocity = velocity.normalized()*speed
	rotation = _rotation


func get_health() -> int:
	return health


func set_health(value: int) -> void:
	health = value

func apply_damage(damage_amount) -> void:
	set_health(get_health() - damage_amount)
	on_health_zero()


func on_health_zero() -> void:
	if health > 0:
		return
	destroy()


func destroy() -> void:
	if is_dead:
		return
	is_dead = false
	queue_free()


func _on_lifespan_timer_timeout() -> void:
	destroy()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group(GameManager.GROUP_METEOR):
		body.apply_damage(damage_amount)
		apply_damage(1)

