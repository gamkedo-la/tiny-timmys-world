extends Node2D

#var level_score: float
@export var level_completion_time: float
@export var level_bgm: AudioStream
#var level_progress: float
#var level_elapsed_time: float

@onready var ui_manager: Node2D = $MainLayer/UIManager

func _ready() -> void:
	PlayerVars.level_score = 0
	PlayerVars.level_progress = 0
	PlayerVars.level_elapsed_time = 0
	PlayerVars.level_completion_time = level_completion_time
	if level_bgm:
		Music.load_and_play_levelbgm(level_bgm)
	
func _process(delta: float) -> void:
	_update_elapsed_time(delta)
	
	PlayerVars.level_progress = PlayerVars.level_elapsed_time / PlayerVars.level_completion_time * 100
	
#	ui_manager.score = level_score
#	ui_manager.progress = level_progress
	if PlayerVars.level_progress >= 100:
		#We won
		ui_manager.level_won = true

#func _on_child_exiting_tree(node: Node) -> void:
#	if node.is_in_group("enemy"):
#		level_score+=node.score
#		print_debug("Level Score: ", level_score)
		
func _update_elapsed_time(delta: float) -> void:
	PlayerVars.level_elapsed_time += delta
