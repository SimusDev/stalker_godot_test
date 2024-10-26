@tool
extends Node
class_name SR_ComponentAlifeNodeSwitcher

@export var node: Node: set = set_node

func set_node(value: Node) -> void:
	node = value
	process_mode = ProcessMode.PROCESS_MODE_DISABLED
