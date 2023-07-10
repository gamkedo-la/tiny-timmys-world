extends Node

@onready var level_bgm: AudioStreamPlayer = $LevelTheme
@onready var sfx: AudioStreamPlayer = $sfx

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var con_res
	if not level_bgm.is_connected("finished", restart_bgm):
		con_res = level_bgm.connect("finished", restart_bgm)
		assert(con_res == OK)
	
	if not Global.is_connected("play_sfx", play_sfx):
		con_res = Global.connect("play_sfx", play_sfx)
		assert(con_res == OK)
	
	if (level_bgm):
		level_bgm.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func load_and_play_levelbgm(track: AudioStream) -> void:
	level_bgm.stream = track
	level_bgm.seek(0.0)
	level_bgm.play()


func restart_bgm() -> void:
	level_bgm.seek(0.0)
	level_bgm.play()
	
func play_sfx(stream) -> void:
	sfx.stream = stream
	sfx.play()
