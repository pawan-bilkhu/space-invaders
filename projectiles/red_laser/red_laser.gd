extends BaseProjectile


func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity*delta)
	if not collision:
		return
	velocity = velocity.bounce(collision.get_normal())
	rotation = atan2(velocity.y, velocity.x)
	velocity = velocity*1.2


