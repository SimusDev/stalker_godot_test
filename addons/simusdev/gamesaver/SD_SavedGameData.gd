extends Resource
class_name SD_SavedGameData

@export var _saveables := {}

@export var _storage := {}

func write_saveable(saveable: W_SaveableNode) -> SD_SavedNodeData:
	var path: String = saveable.get_path()
	
	var node_data = SD_SavedNodeData.new()
	node_data.initialize(saveable, self)
	_saveables[path] = node_data
	return _saveables[path]

func delete_saveable(saveable: W_SaveableNode) -> void:
	var path: String = saveable.get_path()
	
	if not _saveables.has(path):
		return
	
	_saveables.erase(path)

func get_saveable(saveable: W_SaveableNode) -> SD_SavedNodeData:
	var path: String = saveable.get_path()
	return _saveables.get(path) as SD_SavedNodeData

func get_saveable_from_path(path: String) -> SD_SavedNodeData:
	return _saveables.get(path) as SD_SavedNodeData

func get_saved_saveables_dictionary() -> Dictionary:
	return _saveables

func set_value(key: String, value: Variant) -> void:
	_storage[key] = value

func erase_value(key: String) -> void:
	_storage.erase(key)

func get_value(key: String, default_value = null) -> Variant:
	return _storage.get(key, default_value)
