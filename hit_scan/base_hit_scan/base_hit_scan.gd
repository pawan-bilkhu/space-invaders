extends Area2D
class_name BaseHitScan

@export var scale_factor: Vector2 = Vector2.ONE
@export var max_scale: float = 2
@export var scale_rate: float = 0.01
@export var health: int = 0
@export var damage_amount: int = 0
@export var sprite_2d: Sprite2D
var distance_to_body: Vector2
var is_dead: bool = false
var can_scale: bool = true

func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	pass

