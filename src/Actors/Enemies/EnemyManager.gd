extends Node2D

var rng: RandomNumberGenerator
var viewport: Rect2
@export var enemies: Array[PackedScene]
@export var timer_time: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng = RandomNumberGenerator.new()
	$EnemyTimer.wait_time = timer_time
	


func _on_enemy_timer_timeout() -> void:
	var random_enemy = rng.randi_range(0, enemies.size() - 1)
	var enemy_to_spawn = enemies[random_enemy]
	
	var enemy = enemy_to_spawn.instantiate()
	enemy.position = Vector2(position.x, position.y)
	add_sibling(enemy)
