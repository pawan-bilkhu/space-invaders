extends CharacterBody2D

@export var animation_player: AnimationPlayer
@export var scale_factor: Vector2 = Vector2.ONE
@export var initial_velocity: Vector2 = Vector2.ZERO
@export var health: int = 0
var is_dead: bool = false


func _ready() -> void:
	velocity = initial_velocity
	apply_scale(scale_factor)


func _physics_process(delta: float) -> void:
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group(GameManager.GROUP_LASER):
		body.destroy()
		animation_player.play("damaged")
		health -= 1
		on_health_zero()

func on_health_zero() -> void:
	if health > 0:
		return
	destroy()


func destroy() -> void:
	if is_dead:
		return
	is_dead = true
	GameManager.create_explosion(global_position, 5*scale_factor, "fire_explosion")
	queue_free()

