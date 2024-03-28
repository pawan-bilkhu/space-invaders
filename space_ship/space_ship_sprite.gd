extends CharacterBody2D

@export var speed: float = 0
@export var area_2d: Area2D
@export var animation_player: AnimationPlayer
@export var player_camera_2d: Camera2D
@export var animated_sprite_2d: Sprite2D
@export var countdown_time: float = 0.1
@export var weapon_system: Node2D
@export var cpu_particles_2d: CPUParticles2D

var distance_to_mouse =  0
var angle_of_rotation =  0 



enum SHIP_STATE {IDLE, RIGHT, LEFT, UP, DOWN, DAMAGED}

var _state: SHIP_STATE = SHIP_STATE.IDLE
var _is_invincible: bool = false
var _can_shoot: bool = true


func _ready() -> void:
	var random_frame: int = randi_range(0, 4)
	animated_sprite_2d.set_frame(random_frame)


func _physics_process(delta: float) -> void:
	distance_to_mouse =  get_global_mouse_position() - global_position
	angle_of_rotation = atan2(distance_to_mouse.y, distance_to_mouse.x) + PI/2
	# cursor_relative_movement()
	absolute_movement()
	velocity = velocity.normalized()*speed
	weapon_system.initial_velocity = distance_to_mouse.normalized()
	weapon_system.initial_rotation = rotation
	move_and_slide()
	cpu_particles_2d.global_rotation = 0
	cpu_particles_2d.global_position = global_position + Vector2(0, -500)




func reset_kinematic_properties() -> void:
	velocity.x = 0
	velocity.y = 0
	rotation = angle_of_rotation

func cursor_relative_movement() -> void:
	reset_kinematic_properties()
	if Input.is_action_pressed("move_up"):
		velocity = distance_to_mouse
	if Input.is_action_pressed("move_down"):
		velocity = (-1)*distance_to_mouse
	if Input.is_action_pressed("move_left"):
		velocity = distance_to_mouse.orthogonal()
	if Input.is_action_pressed("move_right"):
		velocity = (-1)*distance_to_mouse.orthogonal()

func absolute_movement() -> void:
	reset_kinematic_properties()
	if Input.is_action_pressed("move_up"):
		velocity.y = -1
	if Input.is_action_pressed("move_down"):
		velocity.y = 1
	if Input.is_action_pressed("move_left"):
		velocity.x = -1
	if Input.is_action_pressed("move_right"):
		velocity.x = 1
	
func calculate_states() -> void:
	if _state == SHIP_STATE.DAMAGED:
		return
	
	if velocity.x == 0 and velocity.y == 0:
		set_state(SHIP_STATE.IDLE)
	elif velocity.x > 0:
		set_state(SHIP_STATE.RIGHT)
	elif velocity.x < 0:
		set_state(SHIP_STATE.LEFT)


func set_state(new_state: SHIP_STATE) -> void:
	if new_state == _state:
		return
		
	_state = new_state
	
	match _state:
		SHIP_STATE.IDLE:
			animation_player.play("RESET")
		SHIP_STATE.RIGHT:
			animation_player.play("move_right")
		SHIP_STATE.LEFT:
			animation_player.play("move_left")


func _on_shoot_timer_timeout() -> void:
	_can_shoot = true
