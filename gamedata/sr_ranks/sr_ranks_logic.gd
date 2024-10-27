extends RefCounted
class_name sr_ranks_logic

const RANKS := {
	"novice": 0,
	"stalker": 100,
	"veteran": 300,
	"master": 600,
}

const RANKS_LOCALIZATION := {
	"novice": "rank_novice",
	"stalker": "rank_stalker",
	"veteran": "rank_veteran",
	"master": "rank_master",
}

static func get_rank_id_from_points(points: int) -> String:
	var picked_rank: String
	for id in RANKS.keys():
		var id_points: int = RANKS[id]
		if points >= id_points:
			picked_rank = id
	return picked_rank

static func get_rank_localization_from_points(points: int) -> String:
	return Stalker.localization.get_text_from_key(RANKS_LOCALIZATION.get(get_rank_id_from_points(points), "no_rank"))
