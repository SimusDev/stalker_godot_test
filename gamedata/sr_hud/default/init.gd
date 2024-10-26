extends SR_GameScript

const path: String = "res://gamedata/sr_hud/default/sr_default_hud.tscn"

func _ready() -> void:
	callbacks().SR_Player_ready.connect(_player_ready)

func _player_ready(player: SR_Player):
	var scene: PackedScene = load(path)
	
	var node: Node = scene.instantiate()
	SR_HUD.instance().add_node(node)
	SR_HUD.instance().set_node_static_status(node)
