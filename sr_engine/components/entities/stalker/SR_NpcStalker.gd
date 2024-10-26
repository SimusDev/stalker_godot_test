extends SR_Npc
class_name SR_NpcStalker

func _ready() -> void:
	super()
	
	Stalker.callbacks.SR_NpcStalker_ready.emit(self)
