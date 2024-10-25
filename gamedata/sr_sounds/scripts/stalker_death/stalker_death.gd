extends SR_GameScript

func _on_callback(cb, value):
	if cb == "npc_died":
		if value is SR_NpcStalker:
			var event = spawner().spawn("sound_stalker_death", value)
			Stalker.printc("stalker died: %s" % [value])
