extends Node2D

var rng: RandomNumberGenerator
var viewport: Rect2
@export var pickups: Array[PackedScene]
@export var timer_time: float

func _ready() -> void:
	rng = RandomNumberGenerator.new()
	$PickupTimer.wait_time = timer_time

func _on_spawn_timer_timeout() -> void:
	var random_index = rng.randi_range(0, pickups.size() - 1)
	var class_to_spawn = pickups[random_index]
	
	var object = class_to_spawn.instantiate()
	object.position = Vector2(rng.randi_range(0, get_viewport_rect().size.x), 
		rng.randi_range(0, get_viewport_rect().size.y - 30))
	add_sibling(object)
