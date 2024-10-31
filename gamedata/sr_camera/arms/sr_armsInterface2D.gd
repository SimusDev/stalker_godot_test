extends Node2D
class_name sr_armsInterface2D

@export var _debug_screen: ColorRect

@export var pivot: Node2D
@export var animation: AnimationPlayer

@export var default_animation_prefab: PackedScene

var _arms: sr_inventoryArms

var _item_animation_instance: sr_armsItemAnimation = null

func _ready() -> void:
	if _debug_screen:
		_debug_screen.hide()

func initialize(arms: sr_inventoryArms) -> void:
	if !arms:
		return
	_arms = arms
	arms.slot_selected.connect(_on_slot_selected)
	arms.item_moved_to_slot.connect(_on_item_moved_to_slot)
	arms.item_removed_from_slot.connect(_on_item_removed_from_slot)
	
	update_holding_item()

func _on_slot_selected(slot: SR_InventorySlot) -> void:
	update_holding_item()

func _on_item_moved_to_slot(item: SR_InventoryItem, slot: SR_InventorySlot) -> void:
	if _arms.get_selected_slot() == slot:
		update_holding_item()

func _on_item_removed_from_slot(item: SR_InventoryItem, slot: SR_InventorySlot) -> void:
	if _arms.get_selected_slot() == slot:
		update_holding_item()

func update_holding_item() -> void:
	_remove_animation_instance()
	
	var holding_item: SR_InventoryItem = _arms.get_holding_item()
	if holding_item:
		
		var resource: SR_ResourceWorldItem = holding_item.resource
		if not resource.armsInterface_prefab:
			_create_animation_instance()
			_item_animation_instance.sprite.texture = resource.armsInterface_texture
	
	animation.stop()
	animation.play("pivot_slot_selected")
	

func _remove_animation_instance() -> void:
	if is_instance_valid(_item_animation_instance):
		_item_animation_instance.queue_free()

func _create_animation_instance(scene: PackedScene = default_animation_prefab) -> sr_armsItemAnimation:
	
	_item_animation_instance = scene.instantiate() as sr_armsItemAnimation
	pivot.add_child(_item_animation_instance)
	return _item_animation_instance

func _on_animation_player_animation_started(anim_name: StringName) -> void:
	pass # Replace with function body.

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	pass # Replace with function body.
