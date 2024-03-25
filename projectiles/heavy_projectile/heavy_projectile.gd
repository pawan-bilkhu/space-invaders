extends BaseProjectile


func destroy() -> void:
	if is_dead:
		return
	is_dead = true
	small_explosion(3)
	queue_free()



func _on_lifespan_timer_timeout() -> void:
	super.destroy()
