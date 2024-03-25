extends Area2D
class_name BaseExplosion

@export var animated_sprite_2d: AnimatedSprite2D
@export var animation: StringName = ""
@export var scale_factor: Vector2 = Vector2.ONE
@export var damage_amount: int = 0
var is_dead = false

func _ready() -> void:
	apply_scale(scale_factor)
	animated_sprite_2d.play(animation)


func destroy() -> void:
	if is_dead:
		return
	is_dead = true
	queue_free()


func _on_animated_sprite_2d_animation_finished() -> void:
	destroy()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group(GameManager.GROUP_ASTEROID):
		body.apply_damage(damage_amount)
