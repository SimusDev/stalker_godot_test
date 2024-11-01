extends RefCounted
class_name sr_callbacks

signal sr_inventoryItemInterface_ready(interface: sr_inventoryItemInterface)
signal sr_inventoryItemInterface_action_selected(interface: sr_inventoryItemInterface, action: sr_attribute_action)

signal sr_inventoryItemInterface_grabbed(interface: sr_inventoryItemInterface, position: Vector2)
signal sr_inventoryItemInterface_ungrabbed(interface: sr_inventoryItemInterface, position: Vector2)

signal sr_inventory_item_consumed(inventory: SR_ComponentInventory, item: SR_InventoryItem)

signal sr_cameraRoot_footstep(camera_root: sr_cameraRoot)













static var _instance: sr_callbacks
static func i() -> sr_callbacks:
	return _instance

static func instance() -> sr_callbacks:
	return _instance

static func create(callbacks: Stalker_Callbacks) -> void:
	_instance = sr_callbacks.new()
	Stalker.printc("sr_callbacks initialized!")
