extends SR_GameScript

const path: String = "res://gamedata/sr_ambient/sr_ambient3d.tscn"

func _on_callback(cb: Variant, value: Variant) -> void:
	if cb == "player_ready":
		var player: SR_Player = value as SR_Player
		var scene: PackedScene = load(path)
		
		var node: Node = scene.instantiate()
		player.add_child(node)
		
