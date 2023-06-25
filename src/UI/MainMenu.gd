extends Control

@export var level_scene: PackedScene
@onready var quit_button = $Panel/VBoxContainer/Quit
@onready var fullscreen_toggle = $Panel/VBoxContainer/FullscreenToggle
@onready var credits_button = $Panel/VBoxContainer/Credits
@onready var parallax = $ParallaxBackground
@onready var play_pressed_button = "res://src/UI/play_button_pressed.png"
var parallax_bg_velocity = 1

func _ready() -> void:
	# Hide the Quit button if the game runs in a web browser
	if OS.has_feature("web"):
		quit_button.hide()
		fullscreen_toggle.hide()

func _process(delta: float) -> void:
	parallax.scroll_base_offset.x -= parallax_bg_velocity

func _on_play_pressed() -> void:
	$Panel/VBoxContainer/Play.icon = play_pressed_button
	get_tree().change_scene_to_packed(level_scene)

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_fullscreen_toggle_toggled(button_pressed: bool) -> void:
	Global.set_fullscreen(button_pressed)

func _on_credits_pressed() -> void:
	pass # Replace with function body.
