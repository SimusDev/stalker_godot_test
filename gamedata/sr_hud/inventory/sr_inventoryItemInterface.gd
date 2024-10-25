extends Control
class_name sr_inventoryItemInterface

@export var icon: sr_itemIconInterface

func set_item(item: SR_InventoryItem) -> void:
	var resource: SR_ResourceWorldItem = item.resource
	custom_minimum_size = resource.get_icon_size()
	icon.set_item(item)
