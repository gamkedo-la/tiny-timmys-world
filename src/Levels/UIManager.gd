extends Node2D

@export var progress: float = 0.0
@export var level_won: bool = false

@onready var score_label = $VBoxContainer/ScoreText
@onready var level_progress_bar = $VBoxContainer/LevelProgressBar
@onready var endgame_text = $EndGameText
@onready var boss_health_bar = $VBoxContainer2/BossHealthBar

func _ready() -> void:
	var con_res
	if not Global.is_connected("points_scored", spawn_score):
		con_res = Global.connect("points_scored", spawn_score)
		assert(con_res == OK)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	level_progress_bar.value = PlayerVars.level_progress
	
	if level_won:
		endgame_text.visible = true
		#This shouldn't be here
		get_tree().paused = true
		
	if PlayerVars.has_boss:
		boss_health_bar.visible = true
		boss_health_bar.value = 100 * PlayerVars.boss_health / PlayerVars.boss_max_health


func spawn_score(points: int, pos: Vector2) -> void:
	var new_label = Label.new()
	var lab_tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT_IN).set_parallel(true)
	add_child(new_label)
	new_label.position = pos
#	new_label.global_position = pos
	new_label.text = var_to_str(points)
	lab_tween.tween_property(new_label, "global_position", new_label.global_position * (Vector2.UP/8), 1)
	lab_tween.tween_property(new_label, "scale", Vector2(3.0, 3.0), 1)
	lab_tween.tween_property(new_label, "modulate", Color.GOLD, 1)
	lab_tween.chain().tween_callback(score_points.bind(points))
	lab_tween.chain().tween_callback(new_label.queue_free)
	
func score_points(val: int) -> void:
	
	PlayerVars.level_score += val
	score_label.text = "Score: " + var_to_str(PlayerVars.level_score)
	
	
