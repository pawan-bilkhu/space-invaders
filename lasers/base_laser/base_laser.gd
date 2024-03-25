extends Area2D
class_name BaseLaser


@export var initial_scale: Vector2 = Vector2(1, 1)
@export var max_scale: float = 2
@export var scale_rate: float = 2
@export var offset: float = 15
@export var health: int = 0
@export var damage_amount: int = 0
@export var sprite_2d: Sprite2D
@export var splash_2d: Sprite2D
@export var marker_2d: Marker2D
@export var colour_gradient: Gradient

var splash_2d_scale_factor: float = 0

var distance_to_body: Vector2
var is_dead: bool = false
var can_scale: bool = true

func _ready() -> void:
	splash_2d_scale_factor = splash_2d.scale.x
	pass

func _physics_process(delta: float) -> void:
	on_visible()


func on_visible() -> void:
	if not visible:
		scale = initial_scale
		splash_2d.scale.x = splash_2d_scale_factor/initial_scale.x
		return
	can_scale = true
	emit_beam()
	find_colliding_bodies()


func emit_beam() -> void:
	if can_scale and scale.y < max_scale:
		scale.y += scale_rate
		splash_2d.scale.y = splash_2d_scale_factor/(scale.y)


func find_colliding_bodies() -> void:
	var collisions = get_overlapping_bodies()
	if not collisions:
		return
	can_scale = false
	
	# Calcluate distance to colliding body
	distance_to_body = collisions[0].global_position - global_position
	# Calculate scale-ratio
	var scale_ratio: float = (distance_to_body.length() - collisions[0].sprite_2d.get_rect().size.length() - offset) / (sprite_2d.get_rect().size.y)
	# print("Distance: (%f, %f), \n Scale Ratio: %f" % [distance_to_body.x, distance_to_body.y, scale_ratio])
	# Apply scale-ratio to the beam
	scale.y = scale_ratio
	# Emit particles from Meteor
	apply_damage(collisions[0], 5)
	splash_2d.scale.y = splash_2d_scale_factor/scale_ratio


func apply_damage(body: Node2D, damage_amount: int) -> void:
	if body.is_in_group(GameManager.GROUP_ASTEROID):
		body.emit_particles((-1)*distance_to_body.normalized(), colour_gradient)
		body.apply_damage(damage_amount)
