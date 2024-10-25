extends SR_ResourceNpc
class_name SR_ResourceNpcStalker

func get_prefab() -> PackedScene:
	return load("res://sr_engine/components/entities/stalker/SR_NpcStalker.tscn")
