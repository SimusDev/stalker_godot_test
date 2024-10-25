extends SR_ResourceEffect

@export var points: float = 1.0

func _on_tick(component: SR_CharacterEffectsComponent, delta: float) -> void:
	var health: SR_ComponentHealth = SR_ComponentHealth.find(component.node)
	if health:
		var damage: float = points * strength
		health.apply_damage(damage * delta)
