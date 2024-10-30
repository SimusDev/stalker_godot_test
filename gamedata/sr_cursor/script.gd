extends SR_GameScript

func _ready() -> void:
	resources().loaded.connect(_on_resource_loaded)


func _on_resource_loaded(resource: SR_Resource) -> void:
	if resource.get_section() == "sr_cursor=scene":
		var cursor_node = resource.scene.instantiate()
		
		Stalker.canvas.get_last_layer().add_child(cursor_node)
