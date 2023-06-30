extends Node2D

#var level_score: float
@export var level_completion_time: float
@export var level_bgm: AudioStream
#var level_progress: float
#var level_elapsed_time: float

@onready var ui_manager: Node2D = $MainLayer/UIManager
@onready var boss: Node2D = $MainLayer/SubViewportContainer/PixelViewport/Boss
@onready var pixel_viewport: SubViewport = $MainLayer/SubViewportContainer/PixelViewport
@onready var enemy_manager_timer: Timer = $MainLayer/SubViewportContainer/PixelViewport/EnemyManager/EnemyTimer
@export var heart: PackedScene
@onready var RNG = RandomNumberGenerator.new()

func _ready() -> void:
	PlayerVars.level_score = 0
	PlayerVars.level_progress = 0
	PlayerVars.level_elapsed_time = 0
	PlayerVars.level_completion_time = level_completion_time
	PlayerVars.player_health = 6
	if level_bgm:
		Music.load_and_play_levelbgm(level_bgm)
	boss.process_mode = Node.PROCESS_MODE_DISABLED
	
	var con_res
	if not Global.is_connected("enemy_defeated", spawn_heart_on_enemy_defeat):
		con_res = Global.connect("enemy_defeated", spawn_heart_on_enemy_defeat)
		assert(con_res == OK)
	
func _process(delta: float) -> void:
	_update_elapsed_time(delta)
	
	PlayerVars.level_progress = PlayerVars.level_elapsed_time / PlayerVars.level_completion_time * 100
	
#	ui_manager.score = level_score
#	ui_manager.progress = level_progress
	if PlayerVars.level_progress >= 75:
		#Time for the boss to spawn
		#ui_manager.level_won = true
		boss.process_mode = Node.PROCESS_MODE_INHERIT
		enemy_manager_timer.wait_time = 5.0
	
	if PlayerVars.boss_health <= 0:
		print_debug("Victory!")
	

#func _on_child_exiting_tree(node: Node) -> void:
#	if node.is_in_group("enemy"):
#		level_score+=node.score
#		print_debug("Level Score: ", level_score)
		
func _update_elapsed_time(delta: float) -> void:
	PlayerVars.level_elapsed_time += delta

func spawn_heart_on_enemy_defeat(position: Vector2) -> void:
	var chance = RNG.randf_range(0.0, 1.0)
	if chance > 0.8:
		var new_heart = heart.instantiate()
		new_heart.position = position;
		new_heart.rotation = 0.0;
		pixel_viewport.add_child(new_heart)
