extends Node
class_name SR_CharacterEffectsComponent

@export var node: Node
@export var saveable: W_SaveableNode

@export var _effects: Array[SR_ResourceEffect] = []

signal added(effect: SR_ResourceEffect)
signal removed(effect: SR_ResourceEffect)

func _ready() -> void:
	saveable.data_loaded.connect(_on_data_loaded)
	saveable.data_saved_pre.connect(_on_data_saved_pre)
	
	saveable.load_last_node_data()
	
	for effect in _effects:
		if effect:
			effect._component = self


func _physics_process(delta: float) -> void:
	for effect in _effects:
		effect.tick(self, delta)

func get_effects() -> Array[SR_ResourceEffect]:
	return _effects

func add_effect(effect: SR_ResourceEffect) -> void:
	if not _effects.has(effect):
		effect._component = self
		_effects.append(effect)
		added.emit(effect)

func remove_effect(effect: SR_ResourceEffect) -> void:
	if _effects.has(effect):
		_effects.erase(effect)
		removed.emit(effect)

func replace_same_effects(effect: SR_ResourceEffect) -> void:
	var section: String = effect.get_section()
	if section:
		for old_effect in _effects:
			if old_effect.get_section() == section:
				remove_effect(old_effect)
		
		add_effect(effect)

func give(effect_section: String, time: float = 1.0, strength: float = 1.0) -> SR_ResourceEffect:
	var effect: SR_ResourceEffect = SR_ResourceEffect.create_by_section(effect_section, time, strength)
	add_effect(effect)
	return effect

func _on_data_loaded(data: SD_SavedNodeData) -> void:
	if data:
		var loaded_effects: Array[SR_ResourceEffect] = data.data.sr_effects.duplicate()
		for effect in loaded_effects:
			_effects.append(effect.duplicate())

func _on_data_saved_pre(data: SD_SavedNodeData) -> void:
	data.data.sr_effects = _effects.duplicate()

static func find(node: Node) -> SR_CharacterEffectsComponent:
	for i in node.get_children():
		if i is SR_CharacterEffectsComponent:
			return i
	return null
