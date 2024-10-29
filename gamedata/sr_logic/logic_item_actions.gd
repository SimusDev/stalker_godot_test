extends SR_GameScript

var DEFAULT_ACTIONS: Array[sr_attribute_action] = [
	sr_attribute_action.create("drop", "drop")
]

func _ready():
	sr_callbacks.i().sr_inventoryItemInterface_action_selected.connect(_action_selected)
	sr_callbacks.i().sr_inventoryItemInterface_ready.connect(_item_ready)

func _item_ready(item: sr_inventoryItemInterface) -> void:
	var inv_item: SR_InventoryItem = item.get_item()
	
	for attribute in inv_item.resource.attributes:
		if attribute is sr_attribute_consumable:
			item.add_action(sr_attribute_action.create("use", "use"))
	
	for action in DEFAULT_ACTIONS:
		item.add_action(action)

func _action_selected(interface: sr_inventoryItemInterface, action: sr_attribute_action) -> void:
	var item: SR_InventoryItem = interface.get_item()
	var inventory: SR_ComponentInventory = item.get_inventory()
	match action.id:
		"drop":
			inventory.drop(item)
		"use":
			inventory.use(item)
