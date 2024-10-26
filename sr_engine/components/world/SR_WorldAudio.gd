extends RefCounted
class_name SR_WorldAudio

static func get_world() -> SR_GameWorld:
	return SR_GameWorld.instance()

static func create(node: Node3D = null, at_node_position: bool = true, position: Vector3 = Vector3.ZERO,) -> SR_AudioStreamPlayer3D:
	var audio: SR_AudioStreamPlayer3D
	
	if node == null:
		audio = SR_AudioStreamPlayer3D.new()
		audio.global_position = position
		return audio
	
	audio = SR_AudioStreamPlayer3D.new()
	if at_node_position:
		audio.global_position = position
		SR_GameWorld.teleport_node(audio, node)
		get_world().add_child(audio)
	else:
		node.add_child(audio)
		
	return audio

static func create_at_node_position(node: Node3D) -> SR_AudioStreamPlayer3D:
	return create(node, true, node.global_position)

static func create_at_node(node: Node3D) -> SR_AudioStreamPlayer3D:
	return create(node, false, node.global_position)
