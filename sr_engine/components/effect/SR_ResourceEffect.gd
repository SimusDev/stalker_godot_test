extends SR_Resource
class_name SR_ResourceEffect

@export var time_left: float = 0.0
@export var strength: float = 1.0

@export var hud: bool = true
@export var icon: Texture

var _component: SR_CharacterEffectsComponent

static func create_by_section(section: String, effect_time: float = 1.0, effect_strength: float = 1.0) -> SR_ResourceEffect:
	var resource: SR_ResourceEffect = Stalker.resources.get_resource(section, null)
	if resource is SR_ResourceEffect:
		var created_effect: SR_ResourceEffect = resource.duplicate()
		created_effect.time_left = effect_time
		created_effect.strength = effect_strength
		return created_effect
	return null

func tick(component: SR_CharacterEffectsComponent, delta: float) -> void:
	if not component:
		return
	
	time_left -= delta
	if time_left <= 0.0:
		component.remove_effect(self)
		return
	
	_on_tick(component, delta)

func get_time_left_seconds() -> int:
	return int(time_left)

func _on_tick(component: SR_CharacterEffectsComponent, delta: float) -> void:
	pass
