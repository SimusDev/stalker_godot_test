extends SR_ResourceNpcStalker
class_name SR_ResourcePlayer

func get_prefab() -> PackedScene:
	return load("res://sr_engine/components/entities/player/SR_PLayer.tscn")
