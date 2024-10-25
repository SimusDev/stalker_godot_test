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

static func get_spawner() -> SR_ComponentSpawner:
	return SR_GameWorld.instance().spawner

func _ready() -> void:
	saveable.data_loaded.connect(_on_data_loaded)
	saveable.data_saved_pre.connect(_on_data_saved_pre)
	
	
	saveable.load_last_node_data()
	
	for item in get_items():
		if item:
			item._inventory = self
	
	if get_selected_slot() == null:
		select_first_slot()
	


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

func remove_item_from_slot(item: SR_InventoryItem, slot: SR_InventorySlot) -> void:
	if has_item(item) and has_slot(slot):
		if slot.get_item() == item:
			slot._item = null
			item._slot = null
			item_removed_from_slot.emit(item, slot)
			update_inventory()

func move_item_to_slot(item: SR_InventoryItem, slot: SR_InventorySlot) -> void:
	if has_item(item) and has_slot(slot):
		if item.get_slot() != null:
			remove_item_from_slot(item, item.get_slot())
		item._slot = slot
		slot._item = item
		item_moved_to_slot.emit(item, slot)
		update_inventory()

func update_inventory() -> void:
	updated.emit()

func spawn(section: String, at_node: Node = null) -> SR_InventoryItem:
	var object: Node = get_spawner().spawn(section, at_node)
	if object is SR_WorldItem:
		return pickup(object)
	return null

func pickup(item: SR_WorldItem) -> SR_InventoryItem:
	var inv_item: SR_InventoryItem = SR_InventoryItem.create_from_world_item(item)
	inv_item._inventory = self
	_items.append(inv_item)
	picked_up.emit(inv_item)
	update_inventory()
	return inv_item

func add_item(item: SR_InventoryItem) -> void:
	if _items.has(item):
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
		SR_ComponentSpawner.teleport_node(world_item, at_node)
		dropped.emit(item)
		update_inventory()
		despawn(item)
		return world_item
	return null

func despawn(item: SR_InventoryItem) -> SR_InventoryItem:
	if _items.has(item):
		_items.erase(item)
		update_inventory()
		return item
	return null

func use(item: SR_InventoryItem) -> SR_InventoryItem:
	if has_item(item):
		update_inventory()
		used.emit(item)
		Stalker.callbacks.post("SR_InventoryItem.used", item)
	return item

func clear() -> void:
	_items.clear()

func transfer_item(item: SR_InventoryItem, inventory: SR_ComponentInventory) -> void:
	if not _items.has(item):
		return
	
	var despawned: SR_InventoryItem = despawn(item)
	inventory.add_item(despawned)

func transfer_items(inventory: SR_ComponentInventory) -> void:
	while not _items.is_empty():
		transfer_item(_items[0], inventory)

static func find(node: Node) -> SR_ComponentInventory:
	for i in node.get_children():
		if i is SR_ComponentInventory:
			return i
	return null