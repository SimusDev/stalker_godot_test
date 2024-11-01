extends Control
class_name sr_inventoryContainer

@export var player_inventory := true
@export var flow_container: FlowContainer

@export var item_interface: PackedScene


var _inventory: SR_ComponentInventory

var _popup_actions_instance: Control = null

static var instances: Array[sr_inventoryContainer]

signal itemInterface_clicked(interface: sr_inventoryItemInterface)
signal itemInterface_doubleclicked(interface: sr_inventoryItemInterface)

func _ready() -> void:
	instances.append(self)
	if player_inventory:
		set_inventory(SR_Player.instance().inventory)
	
	
	update_interface()

func _exit_tree() -> void:
	instances.erase(self)

func set_inventory(inventory: SR_ComponentInventory) -> void:
	if _inventory == inventory:
		return
	
	if _inventory:
		if _inventory.updated.is_connected(_on_inventory_updated):
			_inventory.updated.disconnect(_on_inventory_updated)
	
	_inventory = inventory
	_inventory.updated.connect(_on_inventory_updated)
	
	 
	update_interface()

func get_inventory() -> SR_ComponentInventory:
	return _inventory

func _on_inventory_updated() -> void:
	update_interface()

func update_interface() -> void:
	if not _inventory:
		return
	
	if not is_inside_tree():
		return
	
	
	for i in flow_container.get_children():
		i.queue_free()
	
	for item in _inventory.get_items():
		if item.get_inventory().get_item_slot(item) == null:
			var interface: sr_inventoryItemInterface = item_interface.instantiate()
			interface.container = self
			flow_container.add_child(interface)
			interface.set_item(item)
