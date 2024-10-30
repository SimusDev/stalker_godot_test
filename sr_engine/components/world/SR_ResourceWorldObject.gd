extends SR_Resource
class_name SR_ResourceWorldObject

@export var _prefab: PackedScene

@export_group("Icon Settings")
@export var icon: Texture
@export var icon_box_x: int = 1
@export var icon_box_y: int = 1

const icon_box_unit_size: int = 24

func get_icon_size() -> Vector2:
	return Vector2(icon_box_unit_size * icon_box_x, icon_box_unit_size * icon_box_y)

func get_prefab() -> PackedScene:
	return _prefab
