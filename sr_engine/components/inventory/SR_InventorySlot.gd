extends Resource
class_name SR_InventorySlot

@export var data: SR_InventorySlotData
@export var _item: SR_InventoryItem

func get_item() -> SR_InventoryItem:
	return _item
