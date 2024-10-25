extends Area3D
class_name sr_zone3d

signal on_tick()

signal on_node_tick(node: Node)

signal on_npc_tick(npc: SR_Npc)

signal on_item_tick(item: SR_WorldItem)

signal hitbox_entered(hitbox: SR_Hitbox)
signal hitbox_exited(hitbox: SR_Hitbox)

signal npc_entered(npc: SR_Npc)
signal npc_exited(npc: SR_Npc)

signal item_entered(item: SR_WorldItem)
signal item_exited(item: SR_WorldItem)

@export_group("Tick Settings")
@export var timer: Timer
@export var tick_enabled: bool = true
@export var tick_time: float = 1.0

var _nodes: Array[Node] = []
var _hitboxes: Array[SR_Hitbox] = []
var _npcs: Array[SR_Npc] = []
var _items: Array[SR_WorldItem] = []

func _ready() -> void:
	timer.wait_time = tick_time

func get_overlapping_nodes() -> Array[Node]: return _nodes
func get_overlapping_hitboxes() -> Array[SR_Hitbox]: return _hitboxes
func get_overlapping_npcs() -> Array[SR_Npc]: return _npcs
func get_overlapping_items() -> Array[SR_WorldItem]: return _items

func tick() -> void:
	if not tick_enabled:
		return
	
	_tick_placeholder()
	
	for node in _nodes:
		on_node_tick.emit(node)
		
		if node is SR_Npc: on_npc_tick.emit(node)
		if node is SR_WorldItem: on_item_tick.emit(node)
	
	on_tick.emit()

func _tick_placeholder() -> void:
	pass

func _on_area_entered(area: Area3D) -> void:
	_nodes.append(area)
	
	if area is SR_Hitbox:
		_hitboxes.append(area)
		_on_hitbox_entered(area)
		hitbox_entered.emit(area)
	

func _on_area_exited(area: Area3D) -> void:
	_nodes.erase(area)
	
	if area is SR_Hitbox:
		_hitboxes.erase(area)
		_on_hitbox_exited(area)
		hitbox_exited.emit(area)

func _on_hitbox_entered(hitbox: SR_Hitbox) -> void:
	var node: Node = hitbox.node
	
	if not node:
		return
	
	if node is SR_Npc:
		_nodes.append(node)
		_npcs.append(node)
		npc_entered.emit(node)
	if node is SR_WorldItem:
		_nodes.append(node)
		_items.append(node)
		item_entered.emit(node)

func _on_hitbox_exited(hitbox: SR_Hitbox) -> void:
	var node: Node = hitbox.node
	
	if not node:
		return
	
	if node is SR_Npc:
		_nodes.erase(node)
		_npcs.erase(node)
		npc_exited.emit(node)
	if node is SR_WorldItem:
		_nodes.erase(node)
		_items.erase(node)
		item_exited.emit(node)

func _on_timer_timeout() -> void:
	tick()
