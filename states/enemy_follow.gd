extends State
class_name EnemyFollow


@export var enemy: CharacterBody2D
@export var move_speed: float = 40.0
@export var rotation_speed: float = 10.0
var space_ship: CharacterBody2D

func Enter() -> void:
	space_ship = get_tree().get_first_node_in_group("spaceship")
	
func Physics_Update(delta: float) -> void:
	if not space_ship:
		return
	var direction = space_ship.global_position - enemy.global_position
	
	if direction.length() < 800:
		enemy.velocity = direction.normalized()*move_speed
		enemy.rotate_to_target(direction.normalized(), delta)
	else:
		print("transitioning")
		Transitioned.emit(self, "idle")
		

