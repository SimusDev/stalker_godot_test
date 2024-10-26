extends SR_GameScript

const path: String = "res://gamedata/sr_hud/effects/sr_effects_hud.tscn"

var loaded_effects: Array[SR_ResourceEffect] = []

func _ready() -> void:
	resources().loaded.connect(_on_loaded)
	callbacks().SR_Player_ready.connect(_player_ready)

func _on_loaded(resource: SR_Resource) -> void:
	if resource is SR_ResourceEffect:
		loaded_effects.append(resource)

func _player_ready(player: SR_Player) -> void:
	var scene: PackedScene = load(path)
	
	var node: Node = scene.instantiate()
	SR_HUD.instance().add_node(node)
	SR_HUD.instance().set_node_static_status(node)
	node.initialize(player, loaded_effects)
