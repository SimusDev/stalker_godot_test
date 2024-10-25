extends Node2D

@export var DEFAULT_POSITION: Vector2 = Vector2(640, 360)
@export var SWAY_SPEED: float = 10.0

func _ready() -> void:
	Stalker.callbacks.callback.connect(_on_stalker_callback)

func _process(delta: float) -> void:
	position = lerp(position, DEFAULT_POSITION, delta * SWAY_SPEED)

func _on_stalker_callback(cb, value) -> void:
	if cb == "npc_footstep":
		var npc: SR_Npc = value as SR_Npc
		
		position.y -= 10
		
