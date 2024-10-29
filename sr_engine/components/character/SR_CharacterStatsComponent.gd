extends Node
class_name SR_CharacterStatsComponent

@export var node: Node
@export var saveable: W_SaveableNode

@export var faction: SR_ResourceFaction
@export var first_name_key: String
@export var last_name_key: String
@export var nick_name_key: String
@export var rank_points: int = 0 
@export var relation_points: int = 0 

@export var icon: Texture

@export var storage := {}

static func localization():
	return Stalker.localization

static func find(node: Node) -> SR_CharacterStatsComponent:
	return node.get_meta("SR_CharacterStatsComponent")

func _ready() -> void:
	node.set_meta("SR_CharacterStatsComponent", self)
	saveable.data_loaded.connect(_on_data_loaded)
	saveable.data_saved_pre.connect(_on_data_saved_pre)
	
	saveable.load_last_node_data()

func _on_data_loaded(data: SD_SavedNodeData) -> void:
	if data:
		faction = data.load_variable("sr_stats_faction")
		first_name_key = data.load_variable("sr_stats_first_name", "")
		last_name_key = data.load_variable("sr_stats_last_name", "")
		nick_name_key = data.load_variable("sr_stats_nickname", "")
		rank_points = data.load_variable("sr_stats_rank_points", 0)
		relation_points = data.load_variable("sr_stats_relation_points", 0)
		icon = data.load_variable("sr_stats_icon")

func _on_data_saved_pre(data: SD_SavedNodeData) -> void:
	data.save_variable("sr_stats_faction", faction)
	data.save_variable("sr_stats_first_name", first_name_key)
	data.save_variable("sr_stats_last_name", last_name_key)
	data.save_variable("sr_stats_nickname", nick_name_key)
	data.save_variable("sr_stats_rank_points", rank_points)
	data.save_variable("sr_stats_relation_points", relation_points)
	data.save_variable("sr_stats_icon", icon)


func get_the_localized_name() -> String:
	if not nick_name_key.is_empty():
		return localization().get_text_from_key(nick_name_key)
	return "%s %s" % [localization().get_text_from_key(first_name_key), localization().get_text_from_key(last_name_key)]
