@tool
extends TextureButton
class_name sr_button

@export var localization: bool = true
@export var hint: String = "" : set = set_hint

@export var _label: Label

func set_hint(value: String) -> void:
	hint = value
	
	if Engine.is_editor_hint():
		_label.text = value
	else:
		_label.text = Stalker.localization.get_text_from_key(value)
	
