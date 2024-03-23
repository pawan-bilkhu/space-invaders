extends BaseProjectile


func destroy() -> void:
	if is_dead:
		return
	is_dead = true
	explode()
	queue_free()


func explode() -> void:
	GameManager.create_explosion(GameManager.EXPLOSION_KEY.FIRE_EXPLOSION, global_position, 20*Vector2.ONE)
