extends Node3D
class_name SR_Levels

@export var auto_find_level_resources := true
@export var resources: Array[SR_ResourceLevel] = []

var _levels: Array[SR_Level] = []

static var _instance: SR_Levels

static func instance() -> SR_Levels:
	return _instance

static func teleport_node(node: Node3D, teleport_to: Node3D) -> void:
	if not _instance:
		return

func _on_SR_Level_teleported(level: SR_Level, node: Node) -> void:
	if node is SR_Player:
		_update_player_level(node) 

func _update_player_level(player: SR_Player) -> void:
	var player_level: SR_Level = SR_Level.find_level(player)
	
	for level in get_levels():
		level.switch_status(false)
	
	player_level.switch_status(true)
	

func _on_player_ready(player: SR_Player) -> void:
	_update_player_level(player)


func load_nodes_datas() -> void:
	var data: SD_SavedGameData = Stalker.gamesaver.current_save
	
	for node_data in get_ready_saved_nodes(data):
		var packed_scene: PackedScene = load(node_data.scene_file_path)
		var level_resource: SR_ResourceLevel = SR_Level.find_level_resource_in_saved_node_data(node_data)
		
		if level_resource and packed_scene:
			var serialized_node: Node = packed_scene.instantiate()
			serialized_node.name = node_data.node_name
			W_SaveableNode.find_component_in_node(serialized_node).load_data_from_node_data(node_data)
			get_level_by_resource(level_resource).add_child(serialized_node)
			

func get_ready_saved_nodes(data: SD_SavedGameData) -> Array[SD_SavedNodeData]:
	return data.get_saved_dynamic_nodes_array()

func _init() -> void:
	_instance = self

func _ready() -> void:
	Stalker.callbacks.SR_Player_ready.connect(_on_player_ready)
	Stalker.callbacks.SR_Level_teleported.connect(_on_SR_Level_teleported)
	
	if auto_find_level_resources:
		var stalker_resources: Array[Resource] = Stalker.resources.get_loaded_resources() as Array[Resource]
		for res in stalker_resources:
			if res is SR_ResourceLevel:
				resources.append(res)
	
	
	
	Stalker.load_game()
	_levels = initialize_levels()
	load_nodes_datas()
	

func initialize_levels() -> Array[SR_Level]:
	var result: Array[SR_Level] = []
	for res in resources:
		var level: SR_Level = create_level(res)
		result.append(level)
	return result

func create_level(resource: SR_ResourceLevel) -> SR_Level:
	var level := SR_Level.new()
	level.visible = false
	level.resource = resource
	level.name = resource.get_section()
	
	add_child(level)
	
	return level

func get_levels() -> Array[SR_Level]:
	return _levels

func get_level_by_resource(resource: SR_ResourceLevel) -> SR_Level:
	for level in _levels:
		if level.resource == resource:
			return level
	return null
