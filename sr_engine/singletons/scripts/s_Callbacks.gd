extends Node
class_name Stalker_Callbacks

signal callback(cb: Variant, value: Variant)

func initialize() -> void:
	pass

func post(cb: Variant, value: Variant = null) -> void:
	callback.emit(cb, value)
