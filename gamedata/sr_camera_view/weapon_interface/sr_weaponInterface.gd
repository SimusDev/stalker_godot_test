extends Node2D

@export var DEFAULT_POSITION: Vector2 = Vector2(640, 360)
@export var SWAY_SPEED: float = 10.0

func _process(delta: float) -> void:
	position = lerp(position, DEFAULT_POSITION, delta * SWAY_SPEED)
