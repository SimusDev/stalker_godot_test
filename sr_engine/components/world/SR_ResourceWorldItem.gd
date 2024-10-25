extends SR_ResourceWorldObject
class_name SR_ResourceWorldItem

@export var texture_on_floor: Texture
@export var texture_pixel_size: float = 0.01

@export var attributes: Array[SR_Attribute]
@export var storage := {}

func get_prefab() -> PackedScene:
	if not _prefab:
		return load("res://sr_engine/components/item/SR_WorldItem.tscn")
	return _prefab
