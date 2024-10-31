extends Node
class_name W_SaveableNode

@export var enabled: bool = true
@export var node: Node
@export var spawn_ability: bool = false

@export var storage := {}

@export_group("Node Save Properties")
@export var save_properties: Array[String] = [
	"transform",
]

signal data_loaded(node_data: SD_SavedNodeData)
signal data_saved_pre(node_data: SD_SavedNodeData)

var _node_data: SD_SavedNodeData

@export var load_at_ready := true

func _ready() -> void:
	
	if load_at_ready:
		load_data()

func _enter_tree() -> void:
	node.set_meta("W_SaveableNode", self)

func get_node_data() -> SD_SavedNodeData:
	return _node_data

func _init() -> void:
	
	add_to_group(SD_GameSaver.SAVEABLE_NODE_GROUP)
	
	var gamesaver: SD_GameSaver = SimusDev.gamesaver
	gamesaver.game_saved_pre.connect(_on_game_saved_pre)
	gamesaver.game_loaded.connect(_on_game_loaded)

func clear_data_and_despawn() -> void:
	if _node_data:
		_node_data.deinitialize()

func clear_data() -> void:
	clear_data_and_despawn()

func despawn() -> void:
	clear_data_and_despawn()

func _on_game_saved_pre(data: SD_SavedGameData) -> void:
	save_data(data)

func _on_game_loaded(data: SD_SavedGameData) -> void:
	load_data(data)

func save_data(data: SD_SavedGameData = SimusDev.gamesaver.current_save) -> void:
	if not enabled:
		return
	
	var node_data: SD_SavedNodeData = data.write_saveable(self)
	if node_data == null:
		return
	
	_node_data = node_data
	

	
	for property in save_properties:
		node_data.data[property] = node.get(property)
	
	node_data.save_variable("saveable.storage", storage)
	
	data_saved_pre.emit(node_data)
	

func load_data(data: SD_SavedGameData = SimusDev.gamesaver.current_save) -> void:
	if not enabled:
		return
	
	var node_data: SD_SavedNodeData = data.get_saveable(self)
	if node_data:
		load_data_from_node_data(node_data)


func load_data_from_node_data(node_data: SD_SavedNodeData = get_node_data()) -> void:
	if not enabled:
		return
	
	if node_data == null:
		return
	
	_node_data = node_data

		
	for property in save_properties:
		var property_value = node_data.data.get(property, null)
		if property_value != null:
			node.set(property, node_data.data[property])
	
	storage = node_data.load_variable("saveable.storage", {}).duplicate()
	data_loaded.emit(node_data)

func load_last_node_data() -> void:
	if get_node_data():
		load_data_from_node_data(get_node_data())

static func get_all_saveable_components_in_tree() -> Array[W_SaveableNode]:
	var components: Array[W_SaveableNode] = SimusDev.get_tree().get_nodes_in_group(SD_GameSaver.SAVEABLE_NODE_GROUP) as Array[W_SaveableNode]
	return components

static func find_component_in_node(node: Node) -> W_SaveableNode:
	var meta = node.get_meta("W_SaveableNode")
	if meta:
		return meta
	
	for i in node.get_children():
		if i is W_SaveableNode:
			return i
	return null
