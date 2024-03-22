extends CharacterBody2D


@export var speed: float = 200
var is_dead: bool = false


func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	move_and_slide()


func initialize(_starting_position: Vector2, _velocity: Vector2, _rotation) -> void:
	global_position = _starting_position
	velocity = _velocity
	velocity = velocity.normalized()*speed
	rotation = _rotation


func destroy() -> void:
	if is_dead:
		return
	is_dead = false
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	destroy()
