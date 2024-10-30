extends Node2D
class_name sr_armsItemAnimation

@export var _debug_screen: ColorRect
@export var sprite: Sprite2D
@export var animation_player: AnimationPlayer

func _ready() -> void:
	if _debug_screen:
		_debug_screen.queue_free()
