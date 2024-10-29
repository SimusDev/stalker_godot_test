extends SR_GameScript

func _ready():
	Stalker.callbacks.SR_ComponentInventory_used.connect(_inventory_item_used)

func _inventory_item_used(inventory: SR_ComponentInventory, item: SR_InventoryItem) -> void:
	for attribute in item.resource.attributes:
		if attribute is sr_attribute_consumable:
			consume(item)

static func consume(item: SR_InventoryItem) -> void:
	var inventory: SR_ComponentInventory = item.get_inventory()
	if !inventory:
		return
	
	sr_callbacks.i().sr_inventory_item_consumed.emit(inventory, item)
	item.quantity -= 1
	inventory.update_inventory()
	if item.quantity <= 0:
		inventory.despawn(item)
