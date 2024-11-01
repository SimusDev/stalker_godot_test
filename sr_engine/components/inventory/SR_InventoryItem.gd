extends Resource
class_name SR_InventoryItem

@export var resource: SR_ResourceWorldItem
@export var unique_data: Resource

@export var saveables: Array[Resource] = []

@export var quantity: int = 1 : set = set_quantity
var _slot: SR_InventorySlot
var _inventory: SR_ComponentInventory

signal quantity_changed()

func set_quantity(value: int) -> void:
	if quantity == value:
		return
	
	quantity = value
	if quantity > 1 and not resource.stackable:
		quantity = 1
	quantity_changed.emit()
	
	if quantity <= 0:
		get_inventory().despawn(self)
	

func get_inventory() -> SR_ComponentInventory:
	return _inventory

static func create_from_world_item(item: SR_WorldItem) -> SR_InventoryItem:
	var inv_item: SR_InventoryItem = SR_InventoryItem.new()
	inv_item.resource = item.get_resource()
	inv_item.quantity = item.quantity
	inv_item.saveables = item.saveables
	inv_item.unique_data = item.unique_data
	
	SR_Level.find_level(item).despawn(item)
	
	return inv_item

#func get_slot() -> SR_InventorySlot:
	#return _slot
