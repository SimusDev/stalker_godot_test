extends Node
class_name Stalker_Callbacks

signal SR_GameWorld_ready(world: SR_GameWorld)

signal SR_HUD_ready(hud: SR_HUD)
signal SR_HUD_update(hud: SR_HUD)

signal SR_Npc_ready(npc: SR_Npc)
signal SR_Npc_died(npc: SR_Npc)

signal SR_NpcStalker_ready(npc: SR_NpcStalker)

signal SR_Player_ready(player: SR_Player)

signal SR_Level_teleported(level: SR_Level, node: Node)

signal sr_interactableArea_selected(area: sr_interactableArea, interactor: sr_interactor)
signal sr_interactableArea_interacted(area: sr_interactableArea, interactor: sr_interactor)

func initialize() -> void:
	for dict in get_signal_list():
		Stalker.printc("CALLBACK INITIALIZED: %s "% [str(dict)])
