extends AudioStreamPlayer3D
class_name SR_AudioStreamPlayer3D

@export var destroy_after_finished := false

func _ready() -> void:
	finished.connect(_on_finished)

func _on_finished() -> void:
	if destroy_after_finished:
		queue_free()

func play_stream(audio_stream: AudioStream) -> void:
	stream = audio_stream
	play()

func play_streams(audio_streams: Array[AudioStream]) -> void:
	play_stream(SD_Array.get_random_value_from_array(audio_streams))

func play_once(from_position: float) -> void:
	destroy_after_finished = true
	play(from_position)
