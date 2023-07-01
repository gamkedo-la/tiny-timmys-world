extends Control

@export var level_scene: PackedScene
@onready var quit_button = $"Panel/Inner Panel/VBoxContainer/Quit"
@onready var fullscreen_toggle = $"Panel/Inner Panel/VBoxContainer/FullscreenToggle"
@onready var credits_button = $"Panel/Inner Panel/VBoxContainer/Credits"
@onready var score_label = $"Panel/Inner Panel/ScoreLabel"

func _ready() -> void:
	# Hide the Quit button if the game runs in a web browser
	if OS.has_feature("web"):
		quit_button.hide()
		fullscreen_toggle.hide()
	
	var con_res
	
	if not Global.is_connected("player_victorious", _on_player_victorious):
		con_res = Global.connect("player_victorious", _on_player_victorious)
		assert(con_res == OK)

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_fullscreen_toggle_toggled(button_pressed: bool) -> void:
	Global.set_fullscreen(button_pressed)

func _on_restart_level_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_player_victorious() -> void:
	print_debug("On player victorious")
	score_label.text = "Score: " + var_to_str(PlayerVars.level_score)
	get_tree().paused = true
	get_parent().visible = true


func _on_next_level_pressed():
	pass # Replace with function body.


func _on_back_to_menu_pressed():
	pass # Replace with function body.