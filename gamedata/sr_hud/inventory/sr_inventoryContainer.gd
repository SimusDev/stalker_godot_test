extends Control

@export var player_inventory := true
@export var flow_container: FlowContainer

@export var item_interface: PackedScene 

var _inventory: SR_ComponentInventory

func _ready() -> void:
	if player_inventory:
		set_inventory(SR_Player.instance().inventory)
	
	
	update_interface()

func set_inventory(inventory: SR_ComponentInventory) -> void:
	if _inventory == inventory:
		return
	
	if _inventory:
		if _inventory.updated.is_connected(_on_inventory_updated):
			_inventory.updated.disconnect(_on_inventory_updated)
	
	_inventory = inventory
	_inventory.updated.connect(_on_inventory_updated)
	
	 
	update_interface()

func _on_inventory_updated() -> void:
	update_interface()

func update_interface() -> void:
	if not is_inside_tree():
		return
	
	if not _inventory:
		return
	
	for i in flow_container.get_children():
		i.queue_free()
	
	for item in _inventory.get_items():
		var interface: Control = item_interface.instantiate()
		flow_container.add_child(interface)
		interface.set_item(item)
	
