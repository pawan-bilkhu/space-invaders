extends State
class_name EnemyFollow


@export var enemy: CharacterBody2D
@export var move_speed: float = 40.0
var space_ship: CharacterBody2D

func Enter() -> void:
	space_ship = get_tree().get_first_node_in_group("spaceship")
	
func Physics_Update(delta: float) -> void:
	var direction = space_ship.global_position - enemy.global_position
	
	if direction.length() > 25:
		enemy.velocity = direction.normalized()*move_speed
	else:
		enemy.velocity = Vector2()
