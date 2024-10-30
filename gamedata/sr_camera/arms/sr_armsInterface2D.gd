extends Node2D
class_name sr_armsInterface2D

@export var _debug_screen: ColorRect

@export var pivot: Node2D
@export var animation: AnimationPlayer

var _arms: sr_inventoryArms

func _ready() -> void:
	if _debug_screen:
		_debug_screen.hide()

func initialize(arms: sr_inventoryArms) -> void:
	if !arms:
		return
	_arms = arms
	arms.slot_selected.connect(_on_slot_selected)

func _on_slot_selected(slot: SR_InventorySlot) -> void:
	animation.stop()
	animation.play("pivot_slot_selected")


func _on_animation_player_animation_started(anim_name: StringName) -> void:
	pass # Replace with function body.

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	pass # Replace with function body.
