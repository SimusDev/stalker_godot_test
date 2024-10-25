
extends Node

const VERSION: String = "4.0"

var canvas := SD_TrunkCanvas.new()
var eventbus := SD_TrunkEventBus.new()
var localization := SD_TrunkLocalization.new()
var console := SD_TrunkConsole.new()
var input := SD_TrunkInput.new()
var input_keys := SD_InputKeys.new()
var keybindings := SD_TrunkKeyBindings.new()
var modloader := SD_TrunkModLoader.new()

var db_resource := SD_DBResource.new()

var gamesaver := SD_GameSaver.new()

var _autoload_classes = [
	SD_Random.new(),
	SD_Platforms.new(),
	SD_FileSystem.new(),
	SD_FileExtensions.new(),
	SD_ResourceLoader.new(),
	SD_Array.new(),
	SD_Config.new(),
	SD_ConfigEncrypted.new(),
	SD_ConsoleCategories.new(),
	SD_Console.new(),
	SD_ConsoleMessage.new(),
	SD_Settings.new(),
]

func _ready() -> void:
	canvas._ready()
	console._ready()
	
	keybindings._ready()
	
	modloader._ready()

func _process(delta: float) -> void:
	console._process(delta)
	modloader._process(delta)

func _physics_process(delta: float) -> void:
	modloader._physics_process(delta)

func quit(exit_code: int = 0) -> void:
	get_tree().quit(exit_code)
