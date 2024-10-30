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
	Stalker.callbacks.SR_HUD_update.connect(_on_sr_hud_update)
	
	

func _input(event: InputEvent) -> void:
	active_input.emit(event)
	
	if not input_enabled:
		return
	
	input.emit(event)

func _on_sr_hud_update(hud: SR_HUD) -> void:
	input_enabled = hud.get_visible_nodes().is_empty()

static func instance() -> SR_Player:
	return _instance
