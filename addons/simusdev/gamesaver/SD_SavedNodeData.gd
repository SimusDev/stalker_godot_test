extends Resource
class_name SD_SavedNodeData

@export var spawn_ability: bool = false

@export var node_path: String
@export var node_parent_path: String
@export var saveable_path: String

@export var scene_file_path: String

@export var data := {}

var _gamedata: SD_SavedGameData

func initialize(saveable: W_SaveableNode, gamedata: SD_SavedGameData) -> void:
	if not saveable.is_inside_tree():
		return
	
	_gamedata = gamedata
	spawn_ability = saveable.spawn_ability
	node_path = saveable.node.get_path()
	node_parent_path = saveable.node.get_parent().get_path()
	saveable_path = saveable.get_path()
	
	scene_file_path = saveable.node.scene_file_path

func deinitialize() -> void:
	if !_gamedata:
		_gamedata = SimusDev.gamesaver.current_save
	
	if _gamedata:
		_gamedata._saveables.erase(saveable_path)

func get_gamedata() -> SD_SavedGameData:
	return _gamedata

func save_variable(var_name: String, value: Variant) -> void:
	data[var_name] = value

func load_variable(var_name: String, default_value = null) -> Variant:
	var loaded: Variant = data.get(var_name, default_value)
	return loaded
