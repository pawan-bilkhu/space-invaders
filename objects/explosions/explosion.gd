extends Area2D

@export var animated_sprite_2d: AnimatedSprite2D
@export var animation: StringName = "fire_explosion"
@export var scale_factor: Vector2 = Vector2.ONE
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
