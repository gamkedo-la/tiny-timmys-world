extends Control

@onready var timer: Timer = $Timer
@onready var one: TextureRect = $one_countdown
@onready var two: TextureRect = $two_countdown
@onready var three: TextureRect = $three_countdown
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var one_played: bool = false
var two_played: bool = false
var three_played: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), true)
	one.visible = false
	two.visible = false
	get_tree().paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer.time_left < 1:
		one.visible = true
		two.visible = false
		three.visible = false
		if not audio_stream_player.playing and not one_played:
			audio_stream_player.play()
			one_played = true
	elif timer.time_left < 2:
		one.visible = false
		two.visible = true
		three.visible = false
		if not audio_stream_player.playing and not two_played:
			audio_stream_player.play()
			two_played = true
	elif timer.time_left < 3:
		one.visible = false
		two.visible = false
		three.visible = true
		if not audio_stream_player.playing and not three_played:
			audio_stream_player.play()
			three_played = true


func _on_timer_timeout():
	audio_stream_player.play()
	print_debug("Timer timeout")
	get_tree().paused = false
	one.visible = false
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), false)
	set_process_mode(Node.PROCESS_MODE_DISABLED)
