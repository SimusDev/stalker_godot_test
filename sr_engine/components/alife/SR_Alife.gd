extends Node
class_name SR_Alife

static var ___instance: SR_Alife

var _nodes_data := {}

const TICKS_PER_SECOND: int = 10
signal tick()

static func clear_data() -> void:
	instance().get_nodes_data().clear()

static func instance() -> SR_Alife:
	if not ___instance:
		___instance = SR_Alife.new()
		___instance.name = "SR_Alife"
		Stalker.add_child(___instance)
		
		var timer := Timer.new()
		___instance.add_child(timer)
		timer.process_callback = Timer.TIMER_PROCESS_PHYSICS
		timer.wait_time = 1.0 / TICKS_PER_SECOND
		timer.timeout.connect(___instance.___on_tick)
		timer.start()
		
	return ___instance

func ___on_tick() -> void:
	tick.emit()

static func get_nodes_data() -> Dictionary:
	return instance()._nodes_data

static func get_node_data(node: Node) -> SR_AlifeObjectData:
	return instance().get_nodes_data().get(node, null) as SR_AlifeObjectData

static func switch_node(node: Node, status: bool) -> void:
	var nodes_data: Dictionary = get_nodes_data()
	var alife_data := get_node_data(node)
	
	if (status) and (nodes_data.has(node)):
		var last_parent: Node = alife_data.get_last_parent()
		if last_parent:
			last_parent.add_child(node)
		nodes_data.erase(node)
		Stalker.printc("%s %s!" % [str(node), "switched to ONLINE!"])
	
	if (not status) and (not nodes_data.has(node)):
		var created_data := SR_AlifeObjectData.new()
		created_data.parent = node.get_parent()
		created_data.level = SR_Level.find_level(node)
		nodes_data[node] = created_data
		
		created_data.get_last_parent().remove_child(node)
		
		Stalker.printc("%s %s!" % [str(node), "switched to OFFLINE!"])

static func switch_node_online(node: Node) -> void:
	switch_node(node, true)

static func switch_node_offline(node: Node) -> void:
	switch_node(node, false)
