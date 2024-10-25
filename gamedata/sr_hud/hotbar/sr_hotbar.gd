extends Control

@export var slot_prefab: PackedScene
@export var container: HBoxContainer

@export var hotbar_slotdatas: Array[SR_InventorySlotData]

func _ready() -> void:
	var player := SR_Player.instance()
	var inventory := player.inventory
	
	var player_slots: Array[SR_InventorySlot] = get_hotbar_slots(inventory)
	for id in player_slots.size():
		var slot: SR_InventorySlot = player_slots[id]
		var slotInterface: sr_slotInterface = slot_prefab.instantiate()
		container.add_child(slotInterface)
		slotInterface.set_slot(slot)
		slotInterface.set_id(id)
		

func get_hotbar_slots(inventory: SR_ComponentInventory) -> Array[SR_InventorySlot]:
	var result: Array[SR_InventorySlot] = []
	var slots: Array[SR_InventorySlot] = inventory.get_slots()
	for slot in slots:
		if hotbar_slotdatas.has(slot.data):
			result.append(slot)
	return result
