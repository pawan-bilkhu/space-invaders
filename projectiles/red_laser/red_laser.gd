extends BaseProjectile

var _health: int = 3

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity*delta)
	if not collision:
		return
	velocity = velocity.bounce(collision.get_normal())
	velocity = velocity*1.25

func damage() -> void:
	_health -= 1
	if _health > 0:
		return
	super.destroy()
	
