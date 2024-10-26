extends Control
class_name sr_characterStatsInterface

@export var player_stats := true
@export var label: Label
@export var icon: TextureRect
@export var icon_faction: TextureRect

func _ready() -> void:
	if player_stats:
		set_stats_from_character(SR_Player.instance())

func set_stats_from_character(character: Node) -> void:
	var component := SR_CharacterStatsComponent.find(character)
	set_stats(component)

func set_stats(stats: SR_CharacterStatsComponent) -> void:
	if !stats:
		return
	
	icon.texture = stats.icon
	
	var faction_hint: String = "no_faction"
	if stats.faction:
		faction_hint = stats.faction.hint
		icon_faction.texture = stats.faction.icon
	
	var text: String = "%s\n\n%s: %s\n%s: %s" % [
		stats.get_the_localized_name(),
		Stalker.localization.get_text_from_key("rank"),
		sr_ranks_logic.get_rank_localization_from_points(stats.rank_points),
		Stalker.localization.get_text_from_key("faction"),
		Stalker.localization.get_text_from_key(faction_hint),
	]
	
	label.text = text
	#print(sr_ranks_logic.get_rank_localization_from_points(stats.rank_points))
	
