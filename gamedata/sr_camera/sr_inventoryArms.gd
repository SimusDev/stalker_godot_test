extends Node
class_name sr_inventoryArms

@export var inventory: SR_ComponentInventory

func _ready() -> void:
	if !inventory:
		return
	
	inventory.slot_selected.connect(_on_slot_selected)
	inventory.slot_deselected.connect(_on_slot_deselected)

func _on_slot_selected(slot: SR_InventorySlot) -> void:
	pass

func _on_slot_deselected(slot: SR_InventorySlot) -> void:
	pass
