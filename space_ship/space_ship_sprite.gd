extends CharacterBody2D

@export var speed: float = 0
@export var area_2d: Area2D
@export var animation_player: AnimationPlayer
@export var animated_sprite_2d: Sprite2D
@export var weapon_group: Node2D
@export var shoot_timer: Timer
@export var countdown_time: float = 0.1
var weapon_index: int = 0
var weapon_type: Array[GameManager.PROJECTILE_KEY] = [
	GameManager.PROJECTILE_KEY.GREEN_LASER, 
	GameManager.PROJECTILE_KEY.RED_LASER,
	GameManager.PROJECTILE_KEY.ROCKET,
	]
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
	on_shoot()
	select_weapon_type()
	velocity = velocity.normalized()*speed
	move_and_slide()

func select_weapon_type() -> void:
	if Input.is_action_just_pressed("select"):
		weapon_index += 1
		weapon_index = weapon_index % weapon_type.size()


func on_shoot() -> void:
	if not _can_shoot:
		return
	if Input.is_action_pressed("shoot"):
		_can_shoot = false
		var initial_rotation: float = angle_of_rotation
		var inital_velocity: Vector2 = distance_to_mouse.normalized()
		for weapon in weapon_group.get_children():
			GameManager.create_projectile(weapon_type[weapon_index], weapon.global_position, velocity + inital_velocity, initial_rotation)
		start_countdown(countdown_time)


func start_countdown(countdown) -> void:
	shoot_timer.start(countdown)


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
		velocity = Vector2(distance_to_mouse.y, (-1)*distance_to_mouse.x)
	if Input.is_action_pressed("move_right"):
		velocity = Vector2((-1)*distance_to_mouse.y, distance_to_mouse.x)

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
