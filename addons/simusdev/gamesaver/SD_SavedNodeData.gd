extends Resource
class_name SD_SavedNodeData

@export var spawn_ability: bool = false

@export var node_name: String
@export var node_path: String
@export var saveable_path: String

@export var scene_file_path: String

@export var data := {}

var _gamedata: SD_SavedGameData

func initialize(saveable: W_SaveableNode, gamedata: SD_SavedGameData) -> void:
	_gamedata = gamedata
	update_paths(saveable)

func update_paths(saveable: W_SaveableNode) -> void:
	spawn_ability = saveable.spawn_ability
	node_name = saveable.node.name
	
	if not saveable.is_inside_tree():
		return
	
	if not spawn_ability:
		
		node_path = saveable.node.get_path()
		saveable_path = saveable.get_path()
	
	
	scene_file_path = saveable.node.scene_file_path

func deinitialize() -> void:
	if !_gamedata:
		_gamedata = SimusDev.gamesaver.current_save
	
	if _gamedata:
		if spawn_ability:
			_gamedata._dynamic_nodes.erase(self)
		else:
			_gamedata._static_nodes.erase(saveable_path)

func get_gamedata() -> SD_SavedGameData:
	return _gamedata

func save_variable(var_name: String, value: Variant) -> void:
	data[var_name] = value

func load_variable(var_name: String, default_value = null) -> Variant:
	var loaded: Variant = data.get(var_name, default_value)
	return loaded
