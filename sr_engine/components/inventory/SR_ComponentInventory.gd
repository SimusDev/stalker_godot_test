extends Node
class_name SR_ComponentInventory

@export var node: Node
@export var saveable: W_SaveableNode

@export var _items: Array[SR_InventoryItem] = []
@export var _slots: Array[SR_InventorySlot] = []

@export var _selected_slot: SR_InventorySlot 

signal updated()
signal picked_up(item: SR_InventoryItem)
signal dropped(item: SR_InventoryItem)
signal used(item: SR_InventoryItem)

signal item_removed_from_slot(item: SR_InventoryItem, slot: SR_InventorySlot)
signal item_moved_to_slot(item: SR_InventoryItem, slot: SR_InventorySlot)
signal slot_selected(slot: SR_InventorySlot)
signal slot_deselected(slot: SR_InventorySlot)

func select_first_slot() -> void:
	if get_selectable_slots().is_empty():
		return
	
	select_slot(get_selectable_slots()[0])

func select_slot(slot: SR_InventorySlot) -> void:
	if _selected_slot == slot:
		return
	
	if get_selectable_slots().has(slot):
		if _selected_slot and (_selected_slot != slot):
			slot_deselected.emit(_selected_slot)
		_selected_slot = slot
		slot_selected.emit(slot)
		update_inventory()

func get_selected_slot() -> SR_InventorySlot:
	return _selected_slot

func get_selectable_slots() -> Array[SR_InventorySlot]:
	var result: Array[SR_InventorySlot] = []
	for slot in get_slots():
		if slot.data.selectable:
			result.append(slot)
	return result

func get_slot_from_data(data: SR_InventorySlotData) -> SR_InventorySlot:
	for slot in get_slots():
		if slot.data == data:
			return slot
	return null

func _ready() -> void:
	node.set_meta("SR_ComponentInventory", self)
	saveable.data_loaded.connect(_on_data_loaded)
	saveable.data_saved_pre.connect(_on_data_saved_pre)
	
	
	saveable.load_last_node_data()
	
	
	if get_selected_slot() == null:
		select_first_slot()
	
	for item in get_items():
		item._inventory = self
	


func _on_data_loaded(data: SD_SavedNodeData) -> void:
	if data:
		_items = data.data.sr_inventory_items.duplicate()
		_slots = data.data.sr_inventory_slots.duplicate()
		
		_selected_slot = data.data.sr_inventory_selected_slot
	


func _on_data_saved_pre(data: SD_SavedNodeData) -> void:
	data.data.sr_inventory_items = _items
	data.data.sr_inventory_slots = _slots
	data.data.sr_inventory_selected_slot = _selected_slot
	

func get_items() -> Array[SR_InventoryItem]:
	return _items

func get_slots() -> Array[SR_InventorySlot]:
	return _slots

func get_items_by_resource(resource: SR_ResourceWorldItem) -> Array[SR_InventoryItem]:
	var result: Array[SR_InventoryItem] = []
	for item in get_items():
		if item.resource == resource:
			result.append(item)
	return result

func remove_item_from_slot(item: SR_InventoryItem, slot: SR_InventorySlot) -> void:
	if has_item(item) and has_slot(slot):
		if slot.get_item() == item:
			slot._item = null
			item._slot = null
			item_removed_from_slot.emit(item, slot)
			update_inventory()

func move_item_to_slot(item: SR_InventoryItem, slot: SR_InventorySlot) -> void:
	if has_item(item) and has_slot(slot):
		remove_item_from_slot(item, get_item_slot(item))
		item._slot = slot
		slot._item = item
		item_moved_to_slot.emit(item, slot)
		update_inventory()

func is_item_in_slot(item: SR_InventoryItem, slot: SR_InventorySlot) -> bool:
	for i in get_slots():
		if i.get_item() == item:
			return true
	return false

func get_item_slot(item: SR_InventoryItem) -> SR_InventorySlot:
	for i in get_slots():
		if i.get_item() == item:
			return i
	return null

func update_inventory() -> void:
	updated.emit()

func pickup(item: SR_WorldItem) -> SR_InventoryItem:
	var inv_item: SR_InventoryItem = SR_InventoryItem.create_from_world_item(item)
	inv_item._inventory = self
	add_item(inv_item)
	picked_up.emit(inv_item)
	update_inventory()
	return inv_item

func add_item(item: SR_InventoryItem) -> void:
	if _items.has(item):
		return
	
	var items_by_resource: Array[SR_InventoryItem] = get_items_by_resource(item.resource)
	if not items_by_resource.is_empty():
		stack_items(item, items_by_resource[0])
		update_inventory()
		return
	
	_items.append(item)
	update_inventory()

func has_item(item: SR_InventoryItem) -> bool:
	return _items.has(item)

func has_slot(slot: SR_InventorySlot) -> bool:
	return _slots.has(slot)

func drop(item: SR_InventoryItem, at_node: Node = node) -> SR_WorldItem:
	if _items.has(item):
		var world_item: SR_WorldItem = SR_WorldItem.create_from_inventory_item(item)
		SR_GameWorld.teleport_node(world_item, at_node)
		dropped.emit(item)
		update_inventory()
		despawn(item)
		return world_item
	return null

func despawn(item: SR_InventoryItem) -> SR_InventoryItem:
	if _items.has(item):
		item._slot = null
		_items.erase(item)
		update_inventory()
		return item
	return null

func use(item: SR_InventoryItem) -> SR_InventoryItem:
	if has_item(item):
		update_inventory()
		used.emit(item)
		Stalker.callbacks.SR_ComponentInventory_used.emit(self, item)
	return item

func clear() -> void:
	_items.clear()

func stack_items(stackable: SR_InventoryItem, item: SR_InventoryItem) -> SR_InventoryItem:
	if not stackable.stackable:
		return null
	
	if stackable.resource == item.resource:
		item.quantity += stackable.quantity
		return despawn(stackable)
	return null

func sort_stackable_items(item: SR_InventoryItem) -> void:
	var items: Array[SR_InventoryItem] = get_items_by_resource(item.resource)
	while items.size() > 1:
		var first: SR_InventoryItem = items[0]
		var second: SR_InventoryItem = items[1]
		items.erase(first)
		stack_items(first, second)
	

func sort() -> void:
	for item in get_items():
		sort_stackable_items(item)
		

func transfer_item(item: SR_InventoryItem, inventory: SR_ComponentInventory) -> void:
	if not _items.has(item):
		return
	
	var despawned: SR_InventoryItem = despawn(item)
	inventory.add_item(despawned)

func transfer_items(inventory: SR_ComponentInventory) -> void:
	while not _items.is_empty():
		transfer_item(_items[0], inventory)

static func find(node: Node) -> SR_ComponentInventory:
	return node.get_meta("SR_ComponentInventory")
