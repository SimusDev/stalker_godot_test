extends Node
class_name sr_cameraArms

@export var arms: sr_inventoryArms
@export var interface2d: sr_armsInterface2D

func _ready() -> void:
	interface2d.initialize(arms)
