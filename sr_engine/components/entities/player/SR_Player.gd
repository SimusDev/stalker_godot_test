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
	Stalker.callbacks.callback.connect(_on_player_stalker_callback)
	
	Stalker.callbacks.post("player_ready", self)
	

func _on_player_stalker_callback(cb: Variant, value: Variant) -> void:
	if cb is String:
		match cb:
			"hud_updated":
				_on_player_hud_updated(value as SR_HUD)

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
