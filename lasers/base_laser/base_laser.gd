extends RayCast2D
class_name BaseRayCast

@export var line_2d: Line2D
@export var source_particles_2d: CPUParticles2D
@export var target_particles_2d: CPUParticles2D
@export var beam_particles_2d: CPUParticles2D
@export var laser_width: float = 0
@export var damage_rate: int = 0
var can_cast: bool = false


func _ready() -> void:
	set_casting(false)


func _physics_process(delta: float) -> void:
	var cast_point: Vector2 = get_target_position()
	force_raycast_update()
	
	target_particles_2d.emitting = is_colliding()
	if is_colliding():
		cast_point = to_local(get_collision_point())
	line_2d.points[1] = cast_point
	target_particles_2d.position = cast_point
	beam_particles_2d.position = (0.5) * cast_point
	beam_particles_2d.emission_rect_extents.y = cast_point.length() * (0.5)
	
	var collider_object: Object = get_collider()
	if not collider_object:
		return
	if collider_object.has_method("apply_damage"):
		collider_object.apply_damage(damage_rate)
	


func set_casting(cast: bool) -> void:
	can_cast = cast
	if can_cast:
		appear()
	else:
		disappear()
	source_particles_2d.emitting = can_cast
	beam_particles_2d.emitting = can_cast
	set_physics_process(can_cast)


func appear() -> void:
	var tween = get_tree().create_tween().bind_node(line_2d)
	tween.tween_property(line_2d, "width", laser_width, 0.2)


func disappear() -> void:
	var tween = get_tree().create_tween().bind_node(line_2d)
	tween.tween_property(line_2d, "width", 0, 0.2)
	target_particles_2d.emitting = false
