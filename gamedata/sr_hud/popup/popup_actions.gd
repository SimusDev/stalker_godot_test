extends Control

@export var actions: Array[String]

@export var button_scene: PackedScene
@export var container: VBoxContainer

signal selected(action: String)

func _ready() -> void:
	for action in actions:
		var button: Button = button_scene.instantiate()
		button.text = Stalker.localization.get_text_from_key(action)
		button.pressed.connect(_on_button_pressed.bind(button, action))
		container.add_child(button)


func _on_button_pressed(button: Button, action: String) -> void:
	selected.emit(action)
