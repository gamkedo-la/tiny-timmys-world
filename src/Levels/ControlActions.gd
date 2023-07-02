extends Control

func _ready():
	visible = false

func _input(event):
	if event.is_action_pressed("pause"):
		var is_paused = not get_tree().paused
		get_tree().paused = is_paused
		visible = is_paused
#	if event.is_action_pressed("mute"):
#		AudioServer.set_bus_mute(0, not AudioServer.is_bus_mute(0))
