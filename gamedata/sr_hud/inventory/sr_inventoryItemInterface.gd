extends Control
class_name sr_inventoryItemInterface

@export var icon: sr_itemIconInterface
@export var quantity: Label

@export var icon_prefab: PackedScene

var _item: SR_InventoryItem

func get_item() -> SR_InventoryItem:
	return _item

func set_item(item: SR_InventoryItem) -> void:
	_item = item
	var resource: SR_ResourceWorldItem = item.resource
	custom_minimum_size = resource.get_icon_size()
	icon.set_item(item)
	
	quantity.text = str(item.quantity)
	quantity.visible = item.quantity > 1
	

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
			_item.get_inventory().drop(_item)
