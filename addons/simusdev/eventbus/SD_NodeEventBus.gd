@icon("res://addons/simusdev/icons/Timer.svg")
extends Node
class_name SD_NodeEventBus

signal on_event(event: Object)

@onready var eventbus: SD_TrunkEventBus = SimusDev.eventbus

func _ready() -> void:
	eventbus.on_event.connect(_on_event)

func post(event: Object) -> void:
	eventbus.post(event)

func _on_event(event: Object) -> void:
	on_event.emit(event)
