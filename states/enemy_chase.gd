extends State
class_name EnemyChase


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
	enemy.velocity = direction.normalized()*move_speed
	enemy.rotate_to_target(direction.normalized(), delta)



func _on_area_2d_body_exited(body: Node2D) -> void:
	print("Something has exited my detection range")
	if body.is_in_group(GameManager.GROUP_SPACESHIP):
		Transitioned.emit(self, "patrol")
