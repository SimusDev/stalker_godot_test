extends Node
class_name SR_ComponentAudioPlayer

@export var node: Node

func create_stream(stream: AudioStream, source: Node3D) -> SR_AudioStreamPlayer3D:
	var player := SR_AudioStreamPlayer3D.new()
	player.stream = stream
	player.global_position = source.global_position
	return player

func create_streams(streams: Array[AudioStream], source: Node3D) -> SR_AudioStreamPlayer3D:
	var player := SR_AudioStreamPlayer3D.new()
	player.stream = SD_Array.get_random_value_from_array(streams)
	player.global_position = source.global_position
	return player
