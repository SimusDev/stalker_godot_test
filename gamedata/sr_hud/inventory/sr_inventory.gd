extends CanvasLayer
class_name sr_inventory

@export var sound: AudioStreamPlayer
@export var audio_open: AudioStream
@export var audio_close: AudioStream

@export var menu_player_inventory: PackedScene

static var _instance: sr_inventory
var _player: SR_Player

var _menus: Array[Node]

static func instance() -> sr_inventory:
	return _instance 

func _player_input(event: InputEvent) -> void:
	if Stalker.keybinds.is_keybind_just_pressed("inventory"):
		visible = !visible
		
		if visible:
			create_menu(menu_player_inventory)
		

func _init() -> void:
	_instance = self

func _ready() -> void:
	_player = SR_Player.instance()
	_player.active_input.connect(_player_input)
	

func open() -> void:
	visible = true

func close() -> void:
	visible = false

func create_menu(menu: PackedScene) -> Node:
	var menu_node: Node = menu.instantiate()
	_menus.append(menu_node)
	add_child(menu_node)
	return menu_node

func _on_visibility_changed() -> void:
	for i in _menus:
		if is_instance_valid(i):
			i.queue_free()
		_menus.erase(i)
	
	sound.stream = audio_close
	
	if visible:
		sound.stream = audio_open
	
	sound.play()
