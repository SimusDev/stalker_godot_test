extends Node
class_name sr_inventoryArms

@export var inventory: SR_ComponentInventory

@export_group("Player Controller")
@export var controlling_by_player := false
@export var key_shoot: String = "shoot"
@export var key_reload: String = "reload"

@onready var keybinds := Stalker.keybinds

signal interacted(item: SR_InventoryItem)
signal slot_selected(item: SR_InventorySlot)
signal slot_deselected(item: SR_InventorySlot)

signal item_moved_to_slot(item: SR_InventoryItem, slot: SR_InventorySlot)
signal item_removed_from_slot(item: SR_InventoryItem, slot: SR_InventorySlot)

func _ready() -> void:
	inventory.slot_selected.connect(_on_slot_selected)
	inventory.slot_deselected.connect(_on_slot_deselected)
	inventory.item_moved_to_slot.connect(_item_moved_to_slot)
	inventory.item_removed_from_slot.connect(_item_removed_from_slot)
	
	if controlling_by_player:
		SR_Player.instance().input.connect(_on_player_input)

func _item_moved_to_slot(item: SR_InventoryItem, slot: SR_InventorySlot) -> void:
	item_moved_to_slot.emit(item, slot)

func _item_removed_from_slot(item: SR_InventoryItem, slot: SR_InventorySlot) -> void:
	item_moved_to_slot.emit(item, slot)

func _on_slot_selected(slot: SR_InventorySlot) -> void:
	slot_selected.emit(slot)

func _on_slot_deselected(slot: SR_InventorySlot) -> void:
	slot_deselected.emit(slot)

func get_selected_slot() -> SR_InventorySlot:
	return inventory.get_selected_slot()

func get_holding_item() -> SR_InventoryItem:
	var slot: SR_InventorySlot = get_selected_slot()
	if slot:
		return slot.get_item()
	return null

func interact_held_item() -> SR_InventoryItem:
	var item: SR_InventoryItem = get_holding_item()
	if item:
		inventory.use(item)
		interacted.emit(item)
	return null

func try_to_shoot() -> void:
	var item: SR_InventoryItem = get_holding_item()
	if !item:
		return
	
	if item.resource is SR_ResourceWeapon:
		var actor: Node = get_actor()
		var level: SR_Level = SR_Level.find_level(actor)
		var camera: Node3D = actor
		if actor is SR_Npc:
			camera = actor.camera_root
		
		
		sr_weapons.shoot(item, level, camera)
	

func try_to_reload() -> void:
	pass

func _physics_process(delta: float) -> void:
	if !controlling_by_player:
		return
	
	if keybinds.is_keybind_pressed(key_shoot):
		try_to_shoot()
	elif keybinds.is_keybind_just_pressed(key_reload):
		try_to_reload()

func _on_player_input(event: InputEvent) -> void:
	if !controlling_by_player:
		return
	
	

func get_actor() -> Node:
	return inventory.node as Node
