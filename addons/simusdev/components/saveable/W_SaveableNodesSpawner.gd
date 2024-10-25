extends Node
class_name W_SaveableNodesSpawner

@export var node: Node

signal node_spawned(node: Node, node_data: SD_SavedNodeData)

func _init() -> void:
	SimusDev.gamesaver.game_loaded.connect(_on_game_loaded)

func _on_game_loaded(data: SD_SavedGameData) -> void:
	for node_data in get_ready_saved_saveables_nodes(data):
		var packed_scene: PackedScene = load(node_data.scene_file_path)
		if packed_scene:
			var serialized_node: Node = packed_scene.instantiate()
			node.add_child(serialized_node)
			#print(node_data.data)
			W_SaveableNode.find_component_in_node(serialized_node).load_data_from_node_data(node_data)
			node_spawned.emit(serialized_node, node_data)

func get_ready_saved_saveables_nodes(data: SD_SavedGameData) -> Array[SD_SavedNodeData]:
	var result: Array[SD_SavedNodeData] = []
	var saved: Dictionary = data.get_saved_saveables_dictionary()
	for saveable_path in saved:
		var node_data: SD_SavedNodeData = data.get_saveable_from_path(saveable_path)
		if node_data.spawn_ability:
			if not node.has_node(node_data.node_path):
				if not node_data.scene_file_path.is_empty():
					result.append(node_data)
	return result
