extends BaseHitScan


func _physics_process(delta: float) -> void:
	if not visible:
		scale = Vector2.ONE
		return
	if can_scale and scale.y < max_scale:
		scale.y += scale_rate
	var collisions = get_overlapping_bodies()
	if not collisions:
		can_scale = true
		cpu_particles_2d.emitting = false
		return
	cpu_particles_2d.emitting = true
	can_scale = false
	distance_to_body = collisions[0].global_position - global_position
	var scale_ratio: float = (distance_to_body.length() - collisions[0].sprite_2d.get_rect().size.length()) / (sprite_2d.get_rect().size.y)
	print("Distance: (%f, %f), \n Scale Ratio: %f" % [distance_to_body.x, distance_to_body.y, scale_ratio])
	scale.y = scale_ratio
	if collisions[0].is_in_group(GameManager.GROUP_METEOR):
		collisions[0].apply_damage(5)
	cpu_particles_2d.scale.y = 1/scale_ratio





func _on_cpu_particles_2d_visibility_changed():
	cpu_particles_2d.restart()
