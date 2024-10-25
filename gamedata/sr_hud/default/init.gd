extends SR_GameScript

const path: String = "res://gamedata/sr_hud/default/sr_default_hud.tscn"

func _on_callback(cb: Variant, value: Variant) -> void:
	if cb == "player_ready":
		
		var player: SR_Player = value as SR_Player
		var scene: PackedScene = load(path)
		
		var node: Node = scene.instantiate()
		SR_HUD.instance().add_node(node)
		SR_HUD.instance().set_node_static_status(node)
