extends Node3D

@export var location_to_teleport: SR_ResourceLevel

func _on_sr_zone_3d_effects_npc_entered(npc: SR_Npc) -> void:
	var level: SR_Level = SR_Levels.instance().get_level_by_resource(location_to_teleport)
	level.teleport(npc)
	sr_news.send(npc)
