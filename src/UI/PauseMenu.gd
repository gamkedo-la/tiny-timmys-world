extends Control

@export var level_scene: PackedScene
@onready var quit_button = $"Panel/Inner Panel/VBoxContainer/Quit"
@onready var fullscreen_toggle = $"Panel/Inner Panel/VBoxContainer/FullscreenToggle"
@onready var credits_button = $"Panel/Inner Panel/VBoxContainer/Credits"

func _ready() -> void:
	# Hide the Quit button if the game runs in a web browser
	if OS.has_feature("web"):
		quit_button.hide()
		fullscreen_toggle.hide()
	
	var con_res

func _on_play_pressed() -> void:
	get_tree().paused = false
	get_parent().visible = false

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_fullscreen_toggle_toggled(button_pressed: bool) -> void:
	Global.set_fullscreen(button_pressed)

func _on_restart_level_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_back_to_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://src/UI/MainMenu.tscn") 
