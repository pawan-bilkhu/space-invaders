extends BaseHitScan



func _physics_process(delta: float) -> void:
	var collisions = get_overlapping_bodies()
	if can_scale and scale.y < max_scale:
		scale.y += scale_rate
	if not collisions:
		can_scale = true
		return
	can_scale = false
	distance_to_body = collisions[0].global_position - global_position
	var scale_ratio: float = distance_to_body.length()/sprite_2d.get_rect().size.y
	var offset: Vector2 = distance_to_body.normalized()
	offset *= collisions[0].sprite_2d.get_rect().size
	
	print("Distance: (%f, %f), \n Scale Ratio: %f" % [distance_to_body.x, distance_to_body.y, scale_ratio])
	scale.y = scale_ratio



