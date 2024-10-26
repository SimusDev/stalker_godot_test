extends Node3D


func _on_sr_zone_3d_effects_npc_entered(npc: SR_Npc) -> void:
	sr_news.send(npc)
