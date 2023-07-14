extends Node

var level_score: int
@export var level_completion_time: float
var level_progress: float
var level_elapsed_time: float
var high_scores: Array
const MAX_NUM_HIGH_SCORES = 3

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
	if not Global.is_connected("player_victorious", _on_player_victorious):
		con_res = Global.connect("player_victorious", _on_player_victorious)
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
	high_scores.clear()
	if not FileAccess.file_exists(HIGHSCORE_SAVE_PATH):
		print("scores not found")
		return # File DNE	
	var file= FileAccess.open(HIGHSCORE_SAVE_PATH, FileAccess.READ)
	while file.get_position() < file.get_length():
		high_scores.append(file.get_16())
	high_scores = sort_descending(high_scores)
	file.close()

func save_scores() -> void:
	var file = FileAccess.open(HIGHSCORE_SAVE_PATH, FileAccess.WRITE)
	for score in high_scores:
		file.store_16(score)
	file.close()

func update_high_scores() -> void:
	high_scores.append(level_score)
	high_scores = sort_descending(high_scores)
	if (high_scores.size() > MAX_NUM_HIGH_SCORES):
		high_scores.pop_back()

func sort_descending(a: Array) -> Array:
	var index = 0
	for i in range(a.size()):
		for b in range(i+1, a.size()):
			if a[i] < a[b]:
				var temp = a[b]
				a[b] = a[i]
				a[i] = temp
	return a
	
func _on_player_defeated() -> void:
	update_high_scores()
	save_scores()

func _on_player_victorious() -> void:
	update_high_scores()
	save_scores()
	

	
	
