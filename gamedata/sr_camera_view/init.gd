extends SR_GameScript

const sr_cameraViewPath: String = "res://gamedata/sr_camera_view/sr_cameraView.tscn"

func _ready() -> void:
	callbacks().SR_Player_ready.connect(_player_ready)

func _player_ready(player: SR_Player) -> void:
	var scene: PackedScene = load(sr_cameraViewPath)
	
	var node_cameraView: Node = scene.instantiate()
	player.add_child(node_cameraView)
	
