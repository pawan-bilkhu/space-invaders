extends Node2D


@export var space_ship: CharacterBody2D
@export var spawn_interval: float = 5
@export var meteor_generator_timer: Timer

func _ready() -> void:
	meteor_generator_timer.start(spawn_interval)

func _physics_process(delta: float) -> void:
	pass


func _on_meteor_generator_timer_timeout() -> void:
	var ceiling_camera_position: Vector2 = space_ship.player_camera_2d.get_screen_center_position()
	ceiling_camera_position = Vector2(
		randf_range(
			ceiling_camera_position.x - (space_ship.player_camera_2d.get_viewport_rect().size.x)/2, 
			ceiling_camera_position.x + (space_ship.player_camera_2d.get_viewport_rect().size.x)/2
			), 
		ceiling_camera_position.y - (space_ship.player_camera_2d.get_viewport_rect().size.y)/2
		)
	GameManager.create_meteor(ceiling_camera_position, randf_range(-PI/2, PI/2), Vector2(0, randf_range(100, 500)), randi_range(100, 300))
