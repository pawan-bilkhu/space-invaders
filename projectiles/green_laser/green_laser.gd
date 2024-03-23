extends BaseProjectile


func destroy() -> void:
	if is_dead:
		return
	is_dead = true
	super.small_explosion(0.5)
	queue_free()



func _on_lifespan_timer_timeout() -> void:
	super.destroy()
