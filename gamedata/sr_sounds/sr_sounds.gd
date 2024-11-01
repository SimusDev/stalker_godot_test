extends SR_GameScript
class_name sr_sounds

static func play_at_node(stream: AudioStream, node: Node3D) -> SR_AudioStreamPlayer3D:
	var sound := SR_WorldAudio.create_at_node(node)
	if sound:
		sound.stream = stream
		sound.play_once()
	return sound

static func play_at_node_position(stream: AudioStream, node: Node3D) -> SR_AudioStreamPlayer3D:
	var sound := SR_WorldAudio.create_at_node_position(node)
	if sound:
		sound.stream = stream
		sound.play_once()
	return sound
