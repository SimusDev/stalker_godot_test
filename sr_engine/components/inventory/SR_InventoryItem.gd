extends Resource
class_name SR_InventoryItem

@export var resource: SR_ResourceWorldItem

@export var stackable: bool = true
@export var quantity: int = 1 : set = set_quantity
@export var _slot: SR_InventorySlot
var _inventory: SR_ComponentInventory

func set_quantity(value: int) -> void:
	quantity = value
	if quantity > 1 and not stackable:
		quantity = 1
	
	
func get_inventory() -> SR_ComponentInventory:
	return _inventory

static func create_from_world_item(item: SR_WorldItem) -> SR_InventoryItem:
	var inv_item: SR_InventoryItem = SR_InventoryItem.new()
	inv_item.resource = item.get_resource()
	inv_item.stackable = item.stackable
	inv_item.quantity = item.quantity
	
	SR_Level.find_level(item).despawn(item)
	
	return inv_item

func get_slot() -> SR_InventorySlot:
	return _slot
