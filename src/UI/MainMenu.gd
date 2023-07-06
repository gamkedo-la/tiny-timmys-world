extends Control

@export var level_scene: PackedScene
@export var level_selection_scene: PackedScene
@onready var quit_button = $Panel/VBoxContainer/Quit
@onready var fullscreen_toggle = $Panel/VBoxContainer/FullscreenToggle
@onready var credits_button = $Panel/VBoxContainer/Credits

func _ready() -> void:
	# Hide the Quit button if the game runs in a web browser
	if OS.has_feature("web"):
		quit_button.hide()
		fullscreen_toggle.hide()

func _process(delta: float) -> void:
	pass

func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(level_scene)

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_fullscreen_toggle_toggled(button_pressed: bool) -> void:
	Global.set_fullscreen(button_pressed)

func _on_credits_pressed() -> void:
	pass # Replace with function body.


func _on_level_selection_pressed():
	get_tree().change_scene_to_packed(level_selection_scene)
	
#func _input(event):
#	if event.is_action_pressed("mute"):
#		AudioServer.set_bus_mute(0, not AudioServer.is_bus_mute(0))



func _on_volume_up_pressed():
	var music_index= AudioServer.get_bus_index("Master")
	var current_volume = AudioServer.get_bus_volume_db(music_index)
	AudioServer.set_bus_volume_db(music_index, current_volume + 5)


func _on_volume_down_pressed():
	var music_index= AudioServer.get_bus_index("Master")
	var current_volume = AudioServer.get_bus_volume_db(music_index)
	AudioServer.set_bus_volume_db(music_index, current_volume - 5)


func _on_volume_mute_pressed():
	AudioServer.set_bus_mute(0, not AudioServer.is_bus_mute(0))
	
