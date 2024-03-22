extends BaseProjectile


func destroy() -> void:
	if is_dead:
		return
	is_dead = true
	target_hit()
	queue_free()


func target_hit() -> void:
	GameManager.create_explosion(GameManager.EXPLOSION_KEY.SMALL_EXPLOSION, global_position, 0.5*Vector2.ONE)
