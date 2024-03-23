extends StaticBody2D
class_name BaseHitScan

@export var scale_factor: Vector2 = Vector2.ONE
@export var max_scale: float = 2
@export var scale_rate: float = 0.01
@export var health: int = 0
@export var damage_amount: int = 0
var is_dead: bool = false
var is_scaling: bool = true

func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	pass


func small_explosion(scale_factor: float, location: Vector2) -> void:
	GameManager.create_explosion(GameManager.EXPLOSION_KEY.SMALL_EXPLOSION, location, scale_factor*Vector2.ONE)


func fire_explosion(scale_factor: float ) -> void:
	GameManager.create_explosion(GameManager.EXPLOSION_KEY.FIRE_EXPLOSION, global_position, scale_factor*Vector2.ONE)

