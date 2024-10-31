extends Node
class_name SR_ComponentAlifeNode

@export var disabled_at_start: bool = false
@export var node: Node3D

@export var switch_distance: float = 500

func _ready() -> void:
	if disabled_at_start:
		return
	
	_update_level()
	SR_Alife.instance().tick.connect(_on_alife_tick)

func _update_level() -> void:
	var player: SR_Player = SR_Player.instance()
	if !player:
		return
	
	if SR_Level.find_level(player) != SR_Level.find_level(node):
		SR_Alife.switch_node_offline(node)

func _on_alife_tick() -> void:
	var player: SR_Player = SR_Player.instance()
	if !player:
		return
	
	var status: bool = not player.global_position.distance_to(node.position) >= switch_distance
	SR_Alife.switch_node(node, status)
	
	
