extends Node2D

@export var player_camera: Camera2D
@export var space_ship: CharacterBody2D
@export var spawn_interval: float = 5
@export var meteor_generator_timer: Timer

func _ready() -> void:
	meteor_generator_timer.start(spawn_interval)

func _physics_process(delta: float) -> void:
	pass


func _on_meteor_generator_timer_timeout() -> void:
	var ceiling_camera_position: Vector2 = player_camera.get_screen_center_position()
	ceiling_camera_position = Vector2(
		randf_range(
			ceiling_camera_position.x - (player_camera.get_viewport_rect().size.x)/2, 
			ceiling_camera_position.x + (player_camera.get_viewport_rect().size.x)/2
			), 
		ceiling_camera_position.y - (player_camera.get_viewport_rect().size.y)/2
		)
	GameManager.create_meteor(ceiling_camera_position, Vector2(0, randf_range(100, 500)), randi_range(10, 15))
