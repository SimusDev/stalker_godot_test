extends SR_GameScript

const DELTA_SCALE: float = 2.0

func _on_callback(cb: Variant, value: Variant) -> void:
	if cb == "npc_physics_process":
		var npc: SR_Npc = value as SR_Npc
		
		var velocity: Vector3 = npc.character.get_velocity()
		var direction: Vector3 = npc.character.get_move_direction()
		
		if npc.character.body.is_on_floor():
			if abs(velocity):
				npc.db.get_or_add("footstep_delta", 0.0)
				
				npc.db.footstep_delta += get_physics_delta() * DELTA_SCALE
				
				if npc.db.footstep_delta >= 1.0:
					play_step_sound(npc)
					npc.db.footstep_delta = 0.0

func play_step_sound(object: Node3D) -> void:
	if object is SR_Npc:
		pass
	
