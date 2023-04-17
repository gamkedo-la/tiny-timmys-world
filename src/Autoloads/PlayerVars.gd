extends Node

var level_score: int
@export var level_completion_time: float
var level_progress: float
var level_elapsed_time: float

var player: CharacterBody2D = null


var player_health: int
@export var player_slingshot_damage: int = 20
@export var player_stomp_damage: int = 20

var has_boss: bool
var boss_health: int
var boss_max_health: int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
