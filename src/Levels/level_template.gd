extends Node2D

var level_score: float
@export var level_completion_time: float
var level_progress: float
var level_elapsed_time: float

@onready var ui_manager: Node2D = $MainLayer/UIManager

func _ready() -> void:
	level_score = 0
	level_progress = 0
	level_elapsed_time = 0
	
func _process(delta: float) -> void:
	_update_elapsed_time(delta)
	
	level_progress = level_elapsed_time / level_completion_time * 100
	
	ui_manager.score = level_score
	ui_manager.progress = level_progress
	if level_progress >= 100:
		#We won
		ui_manager.level_won = true

func _on_child_exiting_tree(node: Node) -> void:
	if node.is_in_group("enemy"):
		level_score+=node.score
		print_debug("Level Score: ", level_score)
		
func _update_elapsed_time(delta: float) -> void:
	level_elapsed_time += delta
