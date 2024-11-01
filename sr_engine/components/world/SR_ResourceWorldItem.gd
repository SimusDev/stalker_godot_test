extends SR_ResourceWorldObject
class_name SR_ResourceWorldItem

@export var storage := {}
@export var attributes: Array[SR_Attribute]

@export_group("SR_ComponentInventory")
@export var stackable: bool = false

@export_group("SR_WorldItem")
@export var texture_on_floor: Texture
@export var texture_pixel_size: float = 0.01

@export_group("sr_armsInterface2D")
@export var armsInterface_texture: Texture
@export var armsInterface_prefab: PackedScene


func get_prefab() -> PackedScene:
	if not _prefab:
		return load("res://sr_engine/components/item/SR_WorldItem.tscn")
	return _prefab
