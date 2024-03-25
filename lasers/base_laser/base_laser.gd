extends RayCast2D
class_name BaseRayCast

@export var line_2d: Line2D
@export var source_particles: CPUParticles2D
@export var laser_width: float = 0
var can_cast: bool = false


func _ready() -> void:
	set_casting(false)


func _physics_process(delta: float) -> void:
	var cast_point: Vector2 = target_position
	force_raycast_update()
	
	if is_colliding():
		cast_point = to_local(get_collision_point())
	line_2d.points[1] = cast_point


func set_casting(cast: bool) -> void:
	can_cast = cast
	if can_cast:
		appear()
	else:
		disappear()
	source_particles.emitting = can_cast
	set_physics_process(can_cast)


func appear() -> void:
	var tween = get_tree().create_tween().bind_node(line_2d)
	tween.tween_property(line_2d, "width", laser_width, 0.2)


func disappear() -> void:
	var tween = get_tree().create_tween().bind_node(line_2d)
	tween.tween_property(line_2d, "width", 0, 0.2)
