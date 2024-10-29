extends SR_GameScript

var KEYBINDS := {
	"forward": "w",
	"backward": "s",
	"left": "a",
	"right": "d",
	"jump": "space",
	"sprint": "shift",
	"crouch": "ctrl",
	"inventory": "tab",
	"interact": "f",
}

func _ready() -> void:
	for kb_name in KEYBINDS:
		var kb_key: String = KEYBINDS[kb_name]
		Stalker.keybinds.add_keybind(kb_name, kb_key)
