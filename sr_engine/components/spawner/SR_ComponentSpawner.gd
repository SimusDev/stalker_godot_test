extends Node
class_name SR_ComponentSpawner

@export var node: Node

static func teleport_node(node: Node, other_node: Node) -> void:
	return SR_GameWorld.teleport_node(node, other_node)

func spawn_from_scene(packed: PackedScene, at_node: Node = null) -> Node:
	var spawned_node: Node = packed.instantiate()
	
	if spawned_node:
		if at_node:
			teleport_node(spawned_node, at_node)
		node.add_child.call_deferred(spawned_node)
	
	return spawned_node

func spawn_from_section(section: String, at_node: Node = null) -> Node:
	var spawned_node: Node
	
	var resource: SR_Resource = Stalker.resources.get_resource(section)
	
	if resource is SR_ResourceWorldObject:
		var prefab: PackedScene = resource.get_prefab()
		if prefab:
			spawned_node = prefab.instantiate()
		else:
			printc("prefab is empty (%s)" % [resource.get_section()])
	
	
	
	if spawned_node:
		var component_section: SR_ComponentNodeSection = SR_ComponentNodeSection.find_in_node(spawned_node)
		if component_section:
			component_section.name = section
		
		if at_node:
			teleport_node(spawned_node, at_node)
		node.add_child.call_deferred(spawned_node)
	else:
		printc("cant spawn node from section: %s" % [section])
	
	
	return spawned_node

func spawn(section: String, at_node: Node = null) -> Node:
	return spawn_from_section(section, at_node)

func despawn(node: Node) -> void:
	var component: W_SaveableNode = W_SaveableNode.find_component_in_node(node)
	component.enabled = false
	if component:
		component.clear_data()
	node.queue_free()

func printc(message: String) -> void:
	Stalker.printc("(Spawner, %s, %s): %s" % [str(self), str(node), message])
