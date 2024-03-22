extends RigidBody2D

@export var animation_player: AnimationPlayer
@export var scale_factor: Vector2 = Vector2.ONE
@export var initial_force: Vector2 = Vector2.ZERO
@export var health: int = 0
var is_dead: bool = false


func _ready() -> void:
	add_constant_central_force(initial_force)
	apply_scale(scale_factor)


func _physics_process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group(GameManager.GROUP_BASE_LASER):
		body.destroy()
		animation_player.play("damaged")
		health -= 1
	if body.is_in_group(GameManager.GROUP_RICOCHET_LASER):
		health -= 1
		animation_player.play("damaged")
		body.damage()
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


