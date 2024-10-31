extends Resource
class_name SR_AlifeObjectData

var parent: Node
var level: SR_Level

func get_last_parent() -> Node:
	if is_instance_valid(parent):
		return parent
	return level
