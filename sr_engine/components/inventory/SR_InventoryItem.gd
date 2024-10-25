extends Resource
class_name SR_InventoryItem

@export var resource: SR_ResourceWorldItem

@export var _slot: SR_InventorySlot
var _inventory: SR_ComponentInventory

func get_inventory() -> SR_ComponentInventory:
	return _inventory

static func create_from_world_item(item: SR_WorldItem) -> SR_InventoryItem:
	var inv_item: SR_InventoryItem = SR_InventoryItem.new()
	inv_item.resource = item.get_resource()
	
	SR_GameWorld.instance().spawner.despawn(item)
	
	return inv_item

func get_slot() -> SR_InventorySlot:
	return _slot
