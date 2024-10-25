extends CanvasLayer
class_name sr_inventory

@export var sound: AudioStreamPlayer
@export var audio_open: AudioStream
@export var audio_close: AudioStream

static var instance: sr_inventory
var _player: SR_Player

func _player_input(event: InputEvent) -> void:
	if Stalker.keybinds.is_keybind_just_pressed("inventory"):
		visible = !visible

func _ready() -> void:
	instance = self
	Stalker.callbacks.callback.connect(_on_stalker_callback)
	
	_player = SR_Player.instance()
	
	_player.active_input.connect(_player_input)
	


func _on_stalker_callback(cb, value) -> void:
	pass

func _on_visibility_changed() -> void:
	if visible:
		play_sound(audio_open)
	else:
		play_sound(audio_close)

func play_sound(stream: AudioStream) -> void:
	if not is_inside_tree():
		return
	sound.stream = stream
	sound.play()
