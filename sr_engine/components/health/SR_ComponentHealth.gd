extends W_ComponentHealth
class_name SR_ComponentHealth

func _ready() -> void:
	target.set_meta("SR_ComponentHealth", self)

static func find(node: Node) -> SR_ComponentHealth:
	return node.get_meta("SR_ComponentHealth")
