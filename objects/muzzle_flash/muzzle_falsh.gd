extends AnimatedSprite2D

@export var scale_factor: Vector2 = Vector2.ONE
var is_dead = false

func _ready() -> void:
	apply_scale(scale_factor)
	play("flash")


func destroy() -> void:
	if is_dead:
		return
	is_dead = true
	queue_free()

func _on_animation_finished() -> void:
	destroy()
