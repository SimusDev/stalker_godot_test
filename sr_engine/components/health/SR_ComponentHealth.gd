extends W_ComponentHealth
class_name SR_ComponentHealth

static func find(node: Node) -> SR_ComponentHealth:
	for i in node.get_children():
		if i is SR_ComponentHealth:
			return i
	return null
