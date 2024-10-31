extends Area3D
class_name SR_Hurtbox

@export var health: SR_ComponentHealth
@export var damage_multiplier: float = 1.0

func take_from_projectile(projectile: SR_Projectile) -> void:
	appy_damage(projectile.damage)

func appy_damage(points: float) -> void:
	health.apply_damage(points * damage_multiplier)
