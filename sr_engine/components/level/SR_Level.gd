extends Node3D
class_name SR_Level

@export var resource: SR_ResourceLevel

var _levels: SR_Levels

var _base_prefab_instance: Node
var _prefab_nodes: Array[Node]

signal status_switched(status: bool)
signal teleported(node: Node)

func is_online() -> bool:
	return visible

func is_offline() -> bool:
	return !is_online()

func switch_status(status: bool) -> void:
	if visible == status:
		return
	
	visible = status
	
	if is_online():
		process_mode = ProcessMode.PROCESS_MODE_INHERIT
	else:
		process_mode = ProcessMode.PROCESS_MODE_DISABLED
	
	_update_level_prefabs()
	
	status_switched.emit(status)
	

func _ready() -> void:
	_levels = get_parent() as SR_Levels
	
	if resource == null:
		return
	
	_update_level_prefabs()

func _update_level_prefabs() -> void:
	if _base_prefab_instance == null:
		if resource.base_prefab:
			_base_prefab_instance = resource.base_prefab.instantiate()
			add_child(_base_prefab_instance)
			
	
	
	for i in _prefab_nodes:
		_prefab_nodes.erase(i)
		i.queue_free()
	
	
	if is_offline():
		if resource.offline_prefab:
			var offline_node: Node = resource.offline_prefab.instantiate()
			_prefab_nodes.append(offline_node)
			add_child(offline_node)
	
	if is_online():
		if resource.online_prefab:
			var online_node: Node = resource.online_prefab.instantiate()
			_prefab_nodes.append(online_node)
			add_child(online_node)
	

func teleport(node: Node3D, pos = null) -> void:
	if get_children().has(node):
		return
	
	if node.is_inside_tree():
		node.reparent(self)
	
	var saveable: W_SaveableNode = W_SaveableNode.find_component_in_node(node)
	if saveable:
		var data := saveable.get_node_data()
		if data:
			saveable.clear_data()
			SR_Level.set_node_level_resource(node, resource)
			saveable.save_data()
			
	
	SR_Level.set_node_level_resource(node, resource)
	
	if pos != null:
		if pos is Vector3:
			node.position = pos
	
	teleported.emit(node)
	Stalker.callbacks.SR_Level_teleported.emit(self, node)
	

static func find_level_by_parents(node: Node) -> SR_Level:
	if !node.is_inside_tree():
		return null
	
	if node is SR_Levels:
		return null
	
	if node is SR_Level:
		return node
	
	return find_level_by_parents(node.get_parent())

static func find_level(node: Node) -> SR_Level:
	if node is SR_Level:
		return node
	
	var component := W_SaveableNode.find_component_in_node(node)
	if component:
		var levels: SR_Levels = SR_Levels.instance()
		var saved_level_resource: SR_ResourceLevel = component.storage.get("level", null)
		if saved_level_resource and levels:
			return levels.get_level_by_resource(saved_level_resource)
	
	return find_level_by_parents(node)

static func set_node_level_resource(node: Node, level_resource: SR_ResourceLevel) -> void:
	var component := W_SaveableNode.find_component_in_node(node)
	if component:
		component.storage.level = level_resource

static func find_level_resource_in_saved_node_data(data: SD_SavedNodeData) -> SR_ResourceLevel:
	var saveable_storage: Dictionary = data.data.get_or_add("saveable.storage", {}) as Dictionary
	return saveable_storage.get("level", null)


func spawn_from_scene(packed: PackedScene, at_node: Node = null) -> Node:
	var spawned_node: Node = packed.instantiate()
	
	if spawned_node:
		set_node_level_resource(spawned_node, resource)
		
		if at_node:
			SR_GameWorld.teleport_node(spawned_node, at_node)
		add_child.call_deferred(spawned_node)
	
	return spawned_node

func spawn_from_section(section: String, at_node: Node = null) -> Node:
	var resource: SR_Resource = Stalker.resources.get_resource(section)
	if resource:
		return spawn_by_resource(resource)
	return null

func spawn_by_resource(resource: SR_ResourceWorldObject, at_node: Node = null) -> Node:
	var section: String = resource.get_section()
	var spawned_node: Node = null
	var prefab: PackedScene = resource.get_prefab()
	if prefab:
		spawned_node = prefab.instantiate()
	else:
		printc("cant spawn, prefab is empty (%s)" % [resource.get_section()])
	
	if spawned_node:
		set_node_level_resource(spawned_node, self.resource)
		var component_section: SR_ComponentNodeSection = SR_ComponentNodeSection.find_in_node(spawned_node)
		if component_section:
			component_section.name = section
		
		if at_node:
			SR_GameWorld.teleport_node(spawned_node, at_node)
		add_child.call_deferred(spawned_node)
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
	Stalker.printc("(SR_Level, %s): %s" % [str(self), message])
