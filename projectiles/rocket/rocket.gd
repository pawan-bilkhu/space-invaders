extends BaseProjectile


func destroy() -> void:
	if is_dead:
		return
	is_dead = true
	super.fire_explosion(20)
	queue_free()

