@tool
extends EditorPlugin

var AUTOLOAD := {
	"SimusDev" : "res://addons/simusdev/singletons/s_simusdev.tscn"
}

func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	for s in AUTOLOAD:
		add_autoload_singleton(s, AUTOLOAD[s])

func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	for s in AUTOLOAD:
		remove_autoload_singleton(s)
