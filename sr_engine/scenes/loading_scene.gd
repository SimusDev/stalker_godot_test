extends CanvasLayer

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://sr_engine/scenes/gameScene.tscn")
