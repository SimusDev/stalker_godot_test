extends RefCounted
class_name Stalker_GameScripts


var _scripts: Array[SR_GameScript] = []

func initialize() -> void:
	for path in Stalker.gamedata.get_folders():
		var res_path: String = path
		var founded_files := SD_FileSystem.get_all_files_with_extension_from_directory(res_path, SD_FileExtensions.EC_SCRIPT)
		
		for file in founded_files:
			if file is String:
				load_script(file)

func load_script(file: String) -> Resource:
	var resource = null
	
	resource = SD_ResourceLoader.load(file) as GDScript
	var script = resource.new()
	
	if script is SR_GameScript:
		_scripts.append(script)
		script.__initialize__()
		Stalker.printc("script loaded: %s ('%s')" % [file, script.get_script().get_global_name()])
		return resource
	
	if script is Node:
		script.queue_free()
	
	Stalker.printc("failed to load script: %s is not SR_GameScript!!!" % [file])
	
	return null
