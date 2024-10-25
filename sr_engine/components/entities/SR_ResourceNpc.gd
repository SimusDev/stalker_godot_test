extends SR_ResourceEntity
class_name SR_ResourceNpc

func get_prefab() -> PackedScene:
	return load("res://sr_engine/components/entities/npc/SR_Npc.tscn")
