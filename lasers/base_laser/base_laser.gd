extends RayCast2D
class_name BaseRayCast

@export var line_2d: Line2D
@export var casting_particles_2d: GPUParticles2D
@export var collision_particles_2d: GPUParticles2D
@export var beam_particles_2d: GPUParticles2D
@export var laser_width: float = 0
@export var damage_rate: int = 0
var is_casting: bool = false


func _ready() -> void:
	set_casting(false)


func _physics_process(delta: float) -> void:
	var target_point: Vector2 = get_target_position()
	force_raycast_update()
	
	collision_particles_2d.emitting = is_colliding()
	collision_particles_2d.visible = is_colliding()
	if is_colliding():
		target_point = to_local(get_collision_point())
		collision_particles_2d.global_rotation = get_collision_normal().angle() + PI/2
	line_2d.points[1] = target_point
	beam_particles_2d.position = (0.5) * target_point
	collision_particles_2d.position = target_point
	beam_particles_2d.process_material.emission_box_extents.y = target_point.length() * (0.5)
	print("Beam particle box size (%f, %f)" % [beam_particles_2d.process_material.emission_box_extents.x, beam_particles_2d.process_material.emission_box_extents.y])
	print("Length of ray %f" % target_point.length())
	print("Beam particles emitting: ", beam_particles_2d.emitting)
	var collider_object: Object = get_collider()
	if not collider_object:
		return
	if collider_object.has_method("apply_damage"):
		collider_object.apply_damage(damage_rate)
	


func set_casting(cast: bool) -> void:
	is_casting = cast
	casting_particles_2d.emitting = is_casting
	if is_casting:
		appear()
	else:
		collision_particles_2d.emitting = false
		disappear()
	beam_particles_2d.emitting = is_casting
	set_physics_process(is_casting)


func appear() -> void:
	var tween = get_tree().create_tween().bind_node(line_2d)
	tween.tween_property(line_2d, "width", laser_width, 0.2)


func disappear() -> void:
	var tween = get_tree().create_tween().bind_node(line_2d)
	tween.tween_property(line_2d, "width", 0, 0.2)
	
