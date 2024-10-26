extends Control
class_name sr_news

static var _instance: sr_news

@export var _container: VBoxContainer 

@export var prefab: PackedScene

static func instance() -> sr_news:
	return _instance

func _init() -> void:
	_instance = self

func _ready() -> void:
	pass

func __send(text, icon: Texture = null, title: String = "", time: float = 5.0, sound: AudioStream = null) -> sr_news_message:
	
	var message: sr_news_message = prefab.instantiate()
	message.time = time
	message.sound = sound
	
	_container.add_child(message)
	message.set_text(str(text))
	message.set_icon(icon)
	message.set_title(title)
	
	return message

static func send(text, icon: Texture = null, title: String = "", time: float = 5.0, sound: AudioStream = null) -> sr_news_message:
	if _instance == null:
		Stalker.printc("cant send news, sr_news instance is null!")
		return null
	
	return instance().__send(text, icon, title, time, sound)
	
