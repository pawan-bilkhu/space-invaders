extends State
class_name EnemyIdle

@export var enemy: CharacterBody2D
@export var move_speed: float = 10.0
@export var initial_rotation: float = 5.0

var move_direction: Vector2 = Vector2(0, 1)
var wander_time: float


func randomize_wander() -> void:
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(1, 4)

func Enter() -> void:
	randomize_wander()

func Update(delta: float) -> void:
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()

func Physics_Update(delta: float) -> void:
	if enemy:
		enemy.velocity = move_direction * move_speed
