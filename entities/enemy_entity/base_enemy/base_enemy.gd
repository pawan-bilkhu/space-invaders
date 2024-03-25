extends CharacterBody2D
class_name BaseEnemy

@export var animation_player: AnimationPlayer
@export var sprite_2d: Sprite2D
@export var health: int = 0
@export var area_2d: Area2D
var distance_to_body: Vector2
var player_reference: CharacterBody2D


var is_dead: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	rotation += 5*delta
	move_and_slide()
	if not player_reference:
		return
	distance_to_body = player_reference.global_position - global_position
	rotation = atan2(distance_to_body.y, distance_to_body.x) - PI/2


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


func _on_area_2d_body_entered(body):
	if body.is_in_group(GameManager.GROUP_SPACESHIP):
		player_reference = body


func _on_area_2d_body_exited(body):
	if body.is_in_group(GameManager.GROUP_SPACESHIP):
		player_reference = null


func _on_hit_box_2d_body_entered(body):
	pass # Replace with function body.
