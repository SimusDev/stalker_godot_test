extends Node

var console := SimusDev.console
var canvas := SimusDev.canvas
var localization := SimusDev.localization
var callbacks := Stalker_Callbacks.new()
var resources := Stalker_ResourceSectionDataBase.new()
var keybinds := SimusDev.keybindings
var gamedata := Stalker_GameData.new()
var scripts := Stalker_GameScripts.new()

var gamesaver := SimusDev.gamesaver

var world: SR_GameWorld = null

const TICKS_PER_SECOND: float = 20
signal on_tick()

signal on_input(event: InputEvent)

func _ready() -> void:
	
	callbacks.initialize()
	
	gamedata.initialize()
	scripts.initialize()
	resources.initialize()
	
	
	var timer := Timer.new()
	add_child(timer)
	timer.process_callback = Timer.TIMER_PROCESS_PHYSICS
	timer.wait_time = 1.0 / TICKS_PER_SECOND
	timer.timeout.connect(func(): on_tick.emit())
	timer.start()

func _input(event: InputEvent) -> void:
	on_input.emit(event)

func printc(message: String, category: int = 0) -> void:
	console.write("[Stalker] %s" % [message])

func save_game() -> SD_SavedGameData:
	printc("game saved!")
	return gamesaver.save_game("res://saved.tres")

func load_game() -> SD_SavedGameData:
	printc("game loaded!")
	return gamesaver.load_game("res://saved.tres")
