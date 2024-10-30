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
				load_resource(path.get_file(), file)

func load_resource(folder: String, file: String) -> Resource:
	var resource = null
	var generated_section: String = "%s=%s" % [folder, file.get_file().get_basename()]
	
	resource = SD_ResourceLoader.load(file)
	
	if resource is SD_LocalizationResource:
		SimusDev.localization.import_from_resource(resource)
		Stalker.printc("localization loaded: %s" % [file])
		return resource
	
	if resource is SR_Resource:
		if resource._section.is_empty():
			resource._section = generated_section
		_resources[resource.get_section()] = resource
		Stalker.printc("resource loaded: %s ('%s', section: %s)" % [file, resource.get_script().get_global_name(), resource.get_section()])
		loaded.emit(resource)
		return resource
	
	Stalker.printc("failed to load resource: %s (section: %s) is not SR_Resource!!!" % [file, generated_section])
	
	return null

func get_loaded_resources() -> Array[Resource]:
	var result: Array[Resource] = []
	for i in _resources.values():
		if i is Resource:
			result.append(i)
	return result

func get_loaded_sections() -> Array[String]:
	return _resources.keys()

func get_resource(section: String, default_value = null) -> SR_Resource:
	return _resources.get(section, default_value)
