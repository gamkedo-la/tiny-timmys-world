extends Control

@export var level_bgm: AudioStream

# Called when the node enters the scene tree for the first time.
func _ready():
	if level_bgm:
		Music.load_and_play_levelbgm(level_bgm)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_return_pressed():
	get_tree().change_scene_to_file("res://src/UI/MainMenu.tscn")
