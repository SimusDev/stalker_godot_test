extends SR_GameScript

var instance = null

func _ready() -> void:
	callbacks().SR_Player_ready.connect(_player_ready)

func _player_ready(player: SR_Player) -> void:
	var ui: PackedScene = load("res://gamedata/sr_hud/interactables/sr_interactables_hud.tscn")
	instance = ui.instantiate()
	instance.visible = true
	hud().set_node_static_status(instance)
	hud().add_node(instance)
