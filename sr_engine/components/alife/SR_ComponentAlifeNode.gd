extends Node
class_name SR_ComponentAlifeNode

static func find(node: Node) -> SR_ComponentAlifeNode:
	for i in node.get_children():
		if i is SR_ComponentAlifeNode:
			return i
	return null
