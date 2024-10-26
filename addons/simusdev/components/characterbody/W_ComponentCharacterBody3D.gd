extends Node
class_name W_ComponentCharacterBody3D

@export var body: CharacterBody3D

@export var enabled: bool = true

@export var gravity: float = 15.0
@export var jump_force: float = 6.0
@export var move_acceleration: float = 16.0
@export var move_speed: float = 3.5

var _move_direction: Vector3 = Vector3.ZERO

func _physics_process(delta: float) -> void: 
	if !enabled:
		return
	
	_body_physics_process(delta)

func _body_physics_process(delta: float) -> void:
	body.velocity.y -= gravity * delta
	
	var _direction: Vector3 = (body.transform.basis * _move_direction).normalized()
	var acceleration_speed: float = move_acceleration * delta
	if _direction:
		body.velocity.x = lerp(body.velocity.x, _direction.x * move_speed, acceleration_speed)
		body.velocity.z = lerp(body.velocity.z, _direction.z * move_speed, acceleration_speed)
	else:
		body.velocity.x = lerp(body.velocity.x, 0.0, acceleration_speed)
		body.velocity.z = lerp(body.velocity.z, 0.0, acceleration_speed)
	
	body.move_and_slide()

func set_move_direction(direction: Vector3) -> void:
	_move_direction = direction

func get_move_direction() -> Vector3:
	return _move_direction

func get_velocity() -> Vector3:
	return body.velocity

func jump(force: float = jump_force) -> void:
	if body.is_on_floor():
		body.velocity.y += jump_force
	
	
