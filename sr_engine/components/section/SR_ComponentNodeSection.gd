extends Node
class_name SR_ComponentNodeSection

@export var saveable: W_SaveableNode

func _ready() -> void:
	if saveable:
		saveable.data_saved_pre.connect(_on_data_saved_pre)
		saveable.data_loaded.connect(_on_data_loaded)
	
	var node_data: SD_SavedNodeData = saveable.get_node_data()
	if node_data:
		_on_data_loaded(node_data)

func _on_data_saved_pre(data: SD_SavedNodeData) -> void:
	data.data.sr_section = name

func _on_data_loaded(data: SD_SavedNodeData) -> void:
	name = data.data.get("sr_section", "")

func get_resource() -> SR_Resource:
	return Stalker.resources.get_resource(name)

static func find_in_node(node: Node) -> SR_ComponentNodeSection:
	for i in node.get_children():
		if i is SR_ComponentNodeSection:
			return i
	return null
