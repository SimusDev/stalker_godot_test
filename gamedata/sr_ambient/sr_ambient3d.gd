extends Node3D

@export var streams: Array[AudioStream] = []
@export var positions: Array[Marker3D] = []

@export var chance_to_play: float = 0.3

func play_random() -> void:
	var audio := AudioStreamPlayer3D.new()
	audio.finished.connect(_on_audio_finished.bind(audio))
	audio.unit_size = SD_Random.get_rfloat_range(1, 15)
	audio.attenuation_filter_cutoff_hz = 2500
	audio.stream = SD_Array.get_random_value_from_array(streams, null)
	
	var marker: Marker3D = SD_Array.get_random_value_from_array(positions)
	SR_GameWorld.instance().add_child(audio)
	audio.global_position = marker.global_position
	audio.play()
	
	

func _on_audio_finished(audio: AudioStreamPlayer3D) -> void:
	audio.queue_free()

func _on_tick_timeout() -> void:
	var generated: float = SD_Random.get_rfloat_range(0.0, 1.0)
	if chance_to_play >= generated:
		play_random()
