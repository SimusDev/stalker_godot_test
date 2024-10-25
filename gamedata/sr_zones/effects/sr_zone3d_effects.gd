extends sr_zone3d
class_name sr_zone3d_effects

@export var effect_section: String = ""
@export var effect_time: float = 1.0
@export var effect_strength: float = 1.0

func _on_on_node_tick(node: Node) -> void:
	var effects: SR_CharacterEffectsComponent = SR_CharacterEffectsComponent.find(node)
	if effects:
		var created_effect := SR_ResourceEffect.create_by_section(effect_section, effect_time, effect_strength)
		effects.replace_same_effects(created_effect)
