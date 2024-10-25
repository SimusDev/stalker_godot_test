extends Control
class_name sr_characterStatsInterface

@export var icon: TextureRect

func set_stats_from_character(character: Node) -> void:
	var component := SR_CharacterStatsComponent.find(character)
	set_stats(component)

func set_stats(stats: SR_CharacterStatsComponent) -> void:
	if !stats:
		return
	
	
