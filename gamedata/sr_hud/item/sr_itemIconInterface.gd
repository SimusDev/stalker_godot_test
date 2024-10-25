extends TextureRect
class_name sr_itemIconInterface

func set_item(item: SR_InventoryItem) -> void:
	if not item:
		texture = null
		return
	
	texture = item.resource.icon
