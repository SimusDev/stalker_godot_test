extends Control
class_name sr_slotInterface

@export var data: SR_InventorySlotData
@export var label: Label
@export var panel: Panel
@export var quantity: Label

@export var item_interface: sr_inventoryItemInterface

@export var COLOR_DEFAULT: Color = Color.WHITE
@export var COLOR_SELECTED: Color = Color.WHITE

@export var can_drag_and_drop := false

var _id: int = -1
var _slot: SR_InventorySlot
var _player: SR_Player
var _inventory: SR_ComponentInventory

var _grabbed: bool = false

static var instances: Array[sr_slotInterface]

func _ready() -> void:
	instances.append(self)
	_player = SR_Player.instance()
	_inventory = _player.inventory
	
	_player.input.connect(_on_player_input)
	
	_inventory.slot_selected.connect(_on_player_slot_selected)
	_inventory.slot_deselected.connect(_on_player_slot_deselected)
	_inventory.item_moved_to_slot.connect(_on_player_moved_item_to_slot)
	_inventory.item_removed_from_slot.connect(_on_player_removed_item_from_slot)
	_inventory.picked_up.connect(_on_player_picked_up)
	_inventory.dropped.connect(_on_player_dropped)
	_inventory.used.connect(_on_player_used)
	
	if data != null:
		set_slot(_inventory.get_slot_from_data(data))
	
	#print("slot id: %s, %s, %s" % [str(_id), str(_slot), str(_slot.get_item())])
	update_interface()
	
	if can_drag_and_drop:
		var area: sr_dropArea2D = sr_dropArea2D.create_area_to(self)

func _exit_tree() -> void:
	instances.erase(self)

func _on_player_input(event: InputEvent) -> void:
	if _id == -1:
		return
	
	if event is InputEventKey:
		var str_id: String = str(_id + 1)
		if str_id == event.as_text_keycode():
			_inventory.select_slot(_slot)


func update_interface() -> void:
	if _slot and _inventory:
		var item: SR_InventoryItem = _slot.get_item()
		item_interface.set_item(item)
		quantity.visible = false
		if item:
			
			
			
			quantity.text = str(item.quantity)
			quantity.visible = item.quantity > 1
		
		panel.modulate = COLOR_DEFAULT
		if _slot == _inventory.get_selected_slot():
			panel.modulate = COLOR_SELECTED

func _on_player_picked_up(item: SR_InventoryItem) -> void:
	update_interface()

func _on_player_dropped(item: SR_InventoryItem) -> void:
	update_interface()

func _on_player_slot_selected(slot: SR_InventorySlot) -> void:
	update_interface()

func _on_player_slot_deselected(slot: SR_InventorySlot) -> void:
	update_interface()

func _on_player_moved_item_to_slot(item: SR_InventoryItem, slot: SR_InventorySlot) -> void:
	if get_slot() == slot:
		update_interface()

func _on_player_removed_item_from_slot(item: SR_InventoryItem, slot: SR_InventorySlot) -> void:
	if get_slot() == slot:
		update_interface()

func _on_player_used(item: SR_InventoryItem) -> void:
	update_interface()

func set_slot(slot: SR_InventorySlot) -> void:
	_slot = slot
	update_interface()

func get_slot() -> SR_InventorySlot:
	return _slot

func get_inventory() -> SR_ComponentInventory:
	return _inventory

func set_id(id: int) -> void:
	_id = id
	if label:
		label.visible = id >= 0
		label.text = str(id + 1)
	update_interface()


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.double_click:
			if _inventory and get_slot():
				var item: SR_InventoryItem = get_slot().get_item()
				if item:
					_inventory.remove_item_from_slot(item, get_slot())
