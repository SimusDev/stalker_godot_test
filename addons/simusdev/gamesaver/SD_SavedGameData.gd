extends Resource
class_name SD_SavedGameData

@export var _static_nodes := {}
@export var _dynamic_nodes: Array[SD_SavedNodeData] = []

@export var _storage := {}

func write_saveable(saveable: W_SaveableNode) -> SD_SavedNodeData:
	if (saveable.get_node_data() != null) and saveable.spawn_ability:
		return saveable.get_node_data()
		
	var path: String = saveable.get_path()
	
	var node_data = SD_SavedNodeData.new()
	node_data.initialize(saveable, self)
	
	if node_data.spawn_ability:
		SD_Array.append_to_array_no_repeat(_dynamic_nodes, node_data)
		return node_data
	
	_static_nodes[path] = node_data
	return _static_nodes[path]

func delete_saveable(saveable: W_SaveableNode) -> void:
	if not saveable.spawn_ability:
		var path: String = saveable.get_path()
		
		if not _static_nodes.has(path):
			return
		
		_static_nodes.erase(path)
	

func get_saveable(saveable: W_SaveableNode) -> SD_SavedNodeData:
	if not saveable.spawn_ability:
		var path: String = saveable.get_path()
		return _static_nodes.get(path) as SD_SavedNodeData
	return null

func get_saved_static_nodes_dictionary() -> Dictionary:
	return _static_nodes

func get_saved_dynamic_nodes_array() -> Array[SD_SavedNodeData]:
	return _dynamic_nodes

func set_value(key: String, value: Variant) -> void:
	_storage[key] = value

func erase_value(key: String) -> void:
	_storage.erase(key)

func get_value(key: String, default_value = null) -> Variant:
	return _storage.get(key, default_value)
