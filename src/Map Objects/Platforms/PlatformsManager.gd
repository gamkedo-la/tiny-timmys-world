extends Node2D

var rng: RandomNumberGenerator
var viewport: Rect2
@export var heights: Array[int]
@export var platforms: Array[PackedScene]
@export var cell_size: int = 80
@export var timer_time: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng = RandomNumberGenerator.new()
	viewport = get_viewport_rect()
	$PlatformTimer.wait_time = timer_time
	

func _on_platform_timer_timeout() -> void:
	var random_platform = rng.randf_range(0, platforms.size() - 1)
	var platform_to_spawn = platforms[random_platform]
	
	var platform = platform_to_spawn.instantiate()
	var height = viewport.size.y - cell_size * heights[randi() % heights.size()]
	platform.position = Vector2(viewport.size.x, height)
	print_debug("New position: ", platform.position)
	add_child(platform)

