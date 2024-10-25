extends RefCounted
class_name Stalker_ResourceSectionDataBase

var _resources := {}

signal loaded(resource: SR_Resource)

func initialize() -> void:
	for path in Stalker.gamedata.get_folders():
		var res_path: String = path
		var founded_files := SD_FileSystem.get_all_files_with_extension_from_directory(res_path, SD_FileExtensions.EC_RESOURCE)
		
		for file in founded_files:
			if file is String:
				load_resource(file)

func load_resource(file: String) -> Resource:
	var resource = null
	var section: String = file.get_file().get_basename()
	
	resource = SD_ResourceLoader.load(file)
	
	if resource is SR_Resource:
		_resources[section] = resource
		resource._section = section
		Stalker.printc("resource loaded: %s ('%s', section: %s)" % [file, resource.get_script().get_global_name(), section])
		loaded.emit(resource)
		return resource
	
	Stalker.printc("failed to load resource: %s (section: %s) is not SR_Resource!!!" % [file, section])
	
	return null

func get_loaded_resources() -> Array[Resource]:
	return _resources.values()

func get_loaded_sections() -> Array[String]:
	return _resources.keys()

func get_resource(section: String, default_value = null) -> SR_Resource:
	return _resources.get(section, default_value)
