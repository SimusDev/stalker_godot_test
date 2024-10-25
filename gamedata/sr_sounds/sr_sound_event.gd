extends Node3D

@export var play_at_start := true
@export var sounds: Array[AudioStream]
@export var player: AudioStreamPlayer3D

func _ready() -> void:
	if play_at_start:
		play()

func play() -> void:
	player.stream = SD_Array.get_random_value_from_array(sounds)
	player.play()

func _on_sr_audio_stream_player_3d_finished() -> void:
	queue_free()
