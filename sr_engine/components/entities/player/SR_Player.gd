extends SR_NpcStalker
class_name SR_Player

static var _instance: SR_Player

signal input(event: InputEvent)
signal active_input(event: InputEvent)

@export var input_enabled := true

func _enter_tree() -> void:
	_instance = self

func _ready() -> void:
	super()
	Stalker.callbacks.SR_Player_ready.emit(self)
	
	


func _input(event: InputEvent) -> void:
	active_input.emit(event)
	
	if not input_enabled:
		return
	
	input.emit(event)

static func instance() -> SR_Player:
	return _instance
