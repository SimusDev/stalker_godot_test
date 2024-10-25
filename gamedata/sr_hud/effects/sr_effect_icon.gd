extends Control

@export var icon: TextureRect
@export var time: Label
@export var animation: AnimationPlayer

var _resource: SR_ResourceEffect

func initialize(effect: SR_ResourceEffect) -> void:
	_resource = effect
	icon.texture = effect.icon
	
	update_interface()

func _process(delta: float) -> void:
	update_interface()

func update_interface() -> void:
	var seconds: int = _resource.get_time_left_seconds()
	time.text = str(seconds)
	
	if seconds <= 5:
		if not animation.is_playing():
			animation.play("blink")
	
	if seconds == 0:
		time.hide()
