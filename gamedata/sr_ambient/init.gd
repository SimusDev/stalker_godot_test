extends SR_GameScript

const path: String = "res://gamedata/sr_ambient/sr_ambient3d.tscn"

func _ready() -> void:
	callbacks().SR_Player_ready.connect(_player_ready)

func _player_ready(player: SR_Player):
	var scene: PackedScene = load(path)
	
	var node: Node = scene.instantiate()
	player.add_child(node)
	
