extends CanvasLayer

var _player: SR_Player

@export var sr_effect_prefab: PackedScene
@export var container: VBoxContainer

var _interface_effects := {}

func initialize(player: SR_Player, effects: Array[SR_ResourceEffect]) -> void:
	_player = player
	
	_player.effects.added.connect(_on_player_effect_added)
	_player.effects.removed.connect(_on_player_effect_removed)
	
	var player_effects: Array[SR_ResourceEffect] = _player.effects.get_effects()
	for player_effect in player_effects:
		create_effect_interface(player_effect)
	

func create_effect_interface(effect: SR_ResourceEffect) -> void:
	if not effect.hud:
		return
	
	if _interface_effects.has(effect):
		return
	
	var sr_effect: Control = sr_effect_prefab.instantiate()
	container.add_child(sr_effect)
	sr_effect.initialize(effect)
	_interface_effects[effect] = sr_effect

func remove_effect_interface(effect: SR_ResourceEffect) -> void:
	if _interface_effects.has(effect):
		var sr_effect: Control = _interface_effects[effect]
		sr_effect.queue_free()
		_interface_effects.erase(effect)
	

func _on_player_effect_added(effect: SR_ResourceEffect) -> void:
	create_effect_interface(effect)

func _on_player_effect_removed(effect: SR_ResourceEffect) -> void:
	remove_effect_interface(effect)
