extends Control
class_name sr_news_message

@export var _n_icon: TextureRect
@export var _n_title: Label
@export var _n_text: Label
@export var _n_timer: Timer
@export var _n_player: AnimationPlayer

@export var default_icon: Texture
@export var default_title_key: String = "message"
@export var default_sound: AudioStream

var time: float = 5.0
var sound: AudioStream = null


func _ready() -> void:
	_n_timer.wait_time = time
	_n_timer.start()
	
	if sound == null:
		sound = default_sound
		SR_HUD.instance().create_sound(sound).play()

func _on_timer_timeout() -> void:
	_n_player.play("fade")

func get_icon() -> Texture:
	return _n_icon.texture

func set_icon(icon: Texture) -> void:
	_n_icon.texture = icon
	
	if not icon:
		_n_icon.texture = default_icon

func set_text(text: String) -> void:
	_n_text.text = text

func get_text() -> String:
	return _n_text.text

func set_title(title: String) -> void:
	_n_title.text = title
	
	if title.is_empty():
		_n_title.text = Stalker.localization.get_text_from_key(default_title_key)


func get_title() -> String:
	return _n_title.text
