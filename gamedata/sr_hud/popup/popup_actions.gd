extends Control

@export var button_scene: PackedScene
@export var container: VBoxContainer

signal selected(action: sr_attribute_action)

func add_action(action: sr_attribute_action) -> void:
	var button: Button = button_scene.instantiate()
	button.text = Stalker.localization.get_text_from_key(action.hint)
	button.pressed.connect(_on_button_pressed.bind(button, action))
	container.add_child(button)

func _on_button_pressed(button: Button, action: sr_attribute_action) -> void:
	selected.emit(action)
