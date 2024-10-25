extends RefCounted
class_name Stalker_GameData

const PATH: String = "res://gamedata/"

var _folders: Array[String] = []

func initialize() -> void:
	for folder in SD_FileSystem.get_only_folders_from_directory(PATH):
		Stalker.printc("folder found: %s" % [folder])
		_folders.append(folder)

func get_folders() -> Array[String]:
	return _folders
