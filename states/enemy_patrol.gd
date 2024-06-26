extends State
class_name EnemyPatrol

@export var enemy: CharacterBody2D
@export var move_speed: float = 10.0
@export var initial_rotation: float = 5.0
var space_ship: CharacterBody2D

var move_direction: Vector2 = Vector2(0, 1)
var wander_time: float
var is_rotating: bool = false

func randomize_wander_direction() -> void:
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(1, 4)
	is_rotating = true

func Enter() -> void:
	space_ship = get_tree().get_first_node_in_group("spaceship")
	randomize_wander_direction()

func Update(delta: float) -> void:
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander_direction()

func Physics_Update(delta: float) -> void:
	enemy.velocity = move_direction*move_speed
	enemy.rotate_to_target(move_direction, delta)


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Something entered my detection range")
	if body.is_in_group(GameManager.GROUP_SPACESHIP):
		Transitioned.emit(self, "chase")

