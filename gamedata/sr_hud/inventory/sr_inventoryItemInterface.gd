extends Control
class_name sr_inventoryItemInterface

@export var icon: sr_itemIconInterface
@export var quantity: Label

@export var icon_prefab: PackedScene
@export var actions_interface: PackedScene

@export var COLOR_DEFAULT := Color(1, 1, 1, 1)
@export var COLOR_POINTED := Color(1, 1, 1, 1)

var _item: SR_InventoryItem

var container: sr_inventoryContainer

static var _popup_actions_instance = null

var actions: Array[sr_attribute_action] = []

var _grabbed: bool = false
var _last_parent: Node

func _ready() -> void:
	_last_parent = get_parent()
	
	var resource: SR_ResourceWorldItem = _item.resource
	custom_minimum_size = resource.get_icon_size()
	icon.set_item(_item)
	
	quantity.text = str(_item.quantity)
	quantity.visible = _item.quantity > 1
	
	sr_callbacks.i().sr_inventoryItemInterface_ready.emit(self)

func get_item() -> SR_InventoryItem:
	return _item

func set_item(item: SR_InventoryItem) -> void:
	_item = item

func get_slot() -> SR_InventorySlot:
	if !_item:
		return null
	
	return _item.get_inventory().get_item_slot(_item)

func _on_gui_input(event: InputEvent) -> void:
	if !container:
		return
	
	if event is InputEventMouseButton:
		if event.button_index == 2 and !_grabbed:
			if !is_instance_valid(_popup_actions_instance):
				_popup_actions_instance = actions_interface.instantiate()
				
				_popup_actions_instance.selected.connect(_on_action_selected)
				container.add_child(_popup_actions_instance)
				var attributes: Array[SR_Attribute] = get_item().resource.attributes
				for attribute in attributes:
					if attribute is sr_attribute_action:
						_popup_actions_instance.add_action(attribute)
				
				for action in actions:
					_popup_actions_instance.add_action(action)
				
				_popup_actions_instance.global_position = get_global_mouse_position()
		if event.button_index == 1:
			if is_instance_valid(_popup_actions_instance):
				_popup_actions_instance.queue_free()
				_popup_actions_instance = null

func add_action(action: sr_attribute_action) -> void:
	actions.append(action)

func _on_action_selected(action: sr_attribute_action) -> void:
	_popup_actions_instance.queue_free()
	_popup_actions_instance = null
	
	sr_callbacks.i().sr_inventoryItemInterface_action_selected.emit(self, action)
	

func _get_drag_data(at_position: Vector2) -> Variant:
	if is_instance_valid(_popup_actions_instance):
		_popup_actions_instance.queue_free()
		_popup_actions_instance = null
	
	var preview_texture := TextureRect.new()
	preview_texture.texture = icon.texture
	preview_texture.expand_mode = icon.expand_mode
	preview_texture.stretch_mode = icon.stretch_mode
	preview_texture.size = icon.size
	
	var preview := Control.new()
	preview.tree_exited.connect(_on_preview_tree_exited.bind(preview))
	preview.modulate.a = 0.5
	preview.add_child(preview_texture)
	preview_texture.position = -(preview_texture.size / 2)
	set_drag_preview(preview)
	
	_grabbed = true
	sr_callbacks.i().sr_inventoryItemInterface_grabbed.emit(self, preview.global_position)
	return get_item()

func _on_preview_tree_exited(preview: Control) -> void:
	
	var picked_slots: Array[sr_slotInterface] = []
	for slot in sr_slotInterface.instances:
		var distance: float = (slot.size.x + slot.size.y) * 0.5
		if slot.can_drag_and_drop:
			if slot.global_position.distance_to(preview.global_position) <= distance:
				picked_slots.append(slot)
				
	
	picked_slots.sort()
	if !picked_slots.is_empty():
		var slot: sr_slotInterface = picked_slots[0]
		var item: SR_InventoryItem = get_item()
		slot.get_inventory().move_item_to_slot(item, slot.get_slot())
		slot.update_interface()
	
	_grabbed = false
	sr_callbacks.i().sr_inventoryItemInterface_ungrabbed.emit(self, preview.global_position)

func _on_mouse_entered() -> void:
	icon.self_modulate = COLOR_POINTED

func _on_mouse_exited() -> void:
	icon.self_modulate = COLOR_DEFAULT
