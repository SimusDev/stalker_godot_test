extends Control
class_name sr_slotInterface

@export var data: SR_InventorySlotData
@export var label: Label
@export var panel: Panel
@export var icon: sr_itemIconInterface

@export var COLOR_DEFAULT: Color = Color.WHITE
@export var COLOR_SELECTED: Color = Color.WHITE

var _id: int = -1
var _slot: SR_InventorySlot
var _player: SR_Player
var _inventory: SR_ComponentInventory

func _ready() -> void:
	_player = SR_Player.instance()
	_inventory = _player.inventory
	
	_player.input.connect(_on_player_input)
	
	_inventory.slot_selected.connect(_on_player_slot_selected)
	_inventory.slot_deselected.connect(_on_player_slot_deselected)
	
	if data != null:
		set_slot(_inventory.get_slot_from_data(data))

func _on_player_input(event: InputEvent) -> void:
	if _id == -1:
		return
	
	if event is InputEventKey:
		var str_id: String = str(_id + 1)
		if str_id == event.as_text_keycode():
			_inventory.select_slot(_slot)


func update_interface() -> void:
	if _slot and _inventory:
		icon.set_item(_slot.get_item())
		
		panel.self_modulate = COLOR_DEFAULT
		if _slot == _inventory.get_selected_slot():
			panel.self_modulate = COLOR_SELECTED

func _on_player_slot_selected(slot: SR_InventorySlot) -> void:
	update_interface()


func _on_player_slot_deselected(slot: SR_InventorySlot) -> void:
	update_interface()

func set_slot(slot: SR_InventorySlot) -> void:
	_slot = slot
	update_interface()

func set_id(id: int) -> void:
	_id = id
	label.visible = id >= 0
	label.text = str(id + 1)
	update_interface()
