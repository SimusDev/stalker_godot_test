extends sr_attribute_usable
class_name sr_attribute_consumable

static func consume(item: SR_InventoryItem) -> void:
	Stalker.callbacks.post("SR_InventoryItem.consumed", item)
	return item.get_inventory().despawn(item)
