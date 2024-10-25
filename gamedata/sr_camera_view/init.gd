extends SR_GameScript

const sr_cameraViewPath: String = "res://gamedata/sr_camera_view/sr_cameraView.tscn"

func _on_callback(cb: Variant, value: Variant) -> void:
	if cb == "player_ready":
		var player: SR_Player = value as SR_Player
		var scene: PackedScene = load(sr_cameraViewPath)
		
		var node_cameraView: Node = scene.instantiate()
		player.add_child(node_cameraView)
		
