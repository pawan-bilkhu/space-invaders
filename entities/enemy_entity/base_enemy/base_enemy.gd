extends CharacterBody2D
class_name BaseEnemy

@export var animation_player: AnimationPlayer
@export var sprite_2d: Sprite2D
@export var health: int = 0
@export var area_2d: Area2D
@export var rotation_speed: float = 2.0
var distance_to_body: Vector2
var player_reference: CharacterBody2D


var is_dead: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	move_and_slide()


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
	GameManager.create_explosion(GameManager.EXPLOSION_KEY.FIRE_EXPLOSION, global_position, 10*Vector2.ONE)
	queue_free()

func rotate_to_target(direction: Vector2, delta: float):
	var angle_to_target = transform.x.angle_to(direction)
	rotate(sign(angle_to_target) * min(delta*rotation_speed, abs(angle_to_target)))

func _on_area_2d_body_entered(body):
	pass


func _on_area_2d_body_exited(body):
	pass


func _on_hit_box_2d_body_entered(body):
	pass # Replace with function body.
