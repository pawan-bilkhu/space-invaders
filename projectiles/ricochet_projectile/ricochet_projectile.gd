extends BaseProjectile


func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity*delta)
	if not collision:
		return
	velocity = velocity.bounce(collision.get_normal())
	small_explosion(0.5)
	rotation = atan2(velocity.y, velocity.x) + PI/2
	velocity = velocity*1.2


