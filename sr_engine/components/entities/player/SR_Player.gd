extends SR_NpcStalker
class_name SR_Player

@export var camera: W_FPControllerCamera
@export var interactor: sr_interactor

static var _instance: SR_Player

signal input(event: InputEvent)
signal active_input(event: InputEvent)

@export var input_enabled := true

func _enter_tree() -> void:
	_instance = self

func _ready() -> void:
	super()
	Stalker.callbacks.SR_HUD_update.connect(_on_hud_update)
	
	Stalker.callbacks.SR_Player_ready.emit(self)
	
	

func _on_hud_update(hud: SR_HUD) -> void:
	_on_player_hud_updated(hud)

func _on_player_hud_updated(hud: SR_HUD) -> void:
	var visible_nodes_size: int = hud.get_visible_nodes().size()
	input_enabled = visible_nodes_size == 0
	camera.enabled = visible_nodes_size == 0

func _input(event: InputEvent) -> void:
	active_input.emit(event)
	
	if not input_enabled:
		return
	
	input.emit(event)

static func instance() -> SR_Player:
	return _instance
