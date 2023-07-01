extends Control

@export var level_scene: PackedScene
@export var level_selection_scene: PackedScene
@onready var quit_button = $Panel/VBoxContainer/Quit
@onready var fullscreen_toggle = $Panel/VBoxContainer/FullscreenToggle
@onready var credits_button = $Panel/VBoxContainer/Credits
@onready var audio_stream_player = $AudioStreamPlayer2D

func _ready() -> void:
	# Hide the Quit button if the game runs in a web browser
	if OS.has_feature("web"):
		quit_button.hide()
		fullscreen_toggle.hide()
	#audio_stream_player.play()

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
