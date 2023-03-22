extends Node2D


@export var score: int = 0
@export var progress: float = 0.0
@export var level_won: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ScoreText.set_text("Score: %d" % [score])
	$LevelProgressBar.value = progress
	
	if level_won:
		$EndGameText.visible = true
		#This shouldn't be here
		get_tree().paused = true
