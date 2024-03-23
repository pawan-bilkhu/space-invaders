extends BaseHitScan


func _physics_process(delta: float) -> void:
	var collisions = move_and_collide(Vector2.ZERO)
	if collisions:
		is_scaling = false
	if not is_scaling:
		return
	scale_factor.y += scale_rate
	apply_scale(scale_factor)
	if scale.y > max_scale:
		is_scaling = false
		
