extends Node

var level_score: int
@export var level_completion_time: float
var level_progress: float
var level_elapsed_time: float

var player: CharacterBody2D = null

var player_max_health: int = 6
var player_health: int = 6
@export var player_slingshot_damage: int = 20
@export var player_stomp_damage: int = 20

var has_boss: bool
var boss_health: int
var boss_max_health: int

var player_audio_jump = preload("res://src/Audio/Player/jump-1.wav")
const HIGHSCORE_SAVE_PATH = "user://highscores.save"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var con_res
	if not Global.is_connected("player_defeated", _on_player_defeated):
		con_res = Global.connect("player_defeated", _on_player_defeated)
		assert(con_res == OK)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event):
	if event.is_action_pressed("mute"):
		AudioServer.set_bus_mute(0, not AudioServer.is_bus_mute(0))
	
	if event.is_action_pressed("lower_volume"):
		var music_index= AudioServer.get_bus_index("Master")
		var current_volume = AudioServer.get_bus_volume_db(music_index)
		AudioServer.set_bus_volume_db(music_index, current_volume - 5)
		
	if event.is_action_pressed("raise_volume"):
		var music_index= AudioServer.get_bus_index("Master")
		var current_volume = AudioServer.get_bus_volume_db(music_index)
		AudioServer.set_bus_volume_db(music_index, current_volume + 5)
		
func load_scores() -> void:
	if not FileAccess.file_exists(HIGHSCORE_SAVE_PATH):
		print("scores not found")
		return # File DNE	
	var file= FileAccess.open(HIGHSCORE_SAVE_PATH, FileAccess.READ)
	var content = file.get_16()
	file.close()

func save_scores() -> void:
	var file = FileAccess.open(HIGHSCORE_SAVE_PATH, FileAccess.WRITE)
	file.store_16(level_score)
	file.close()

	
func _on_player_defeated() -> void:
	save_scores()
	

	
	
