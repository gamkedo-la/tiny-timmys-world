extends Node2D

@export var tile_set: TileSet

var viewport_width: int = 0
var viewport_height: int = 0
var pixel_cell_counter: float
var pixel_total_movement_counter: float
var floor_tilemap: TileMap
const SPEED: float = -16.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_spawn_new_random_floor()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _spawn_new_random_floor() -> void:
	var new_floor: TileMap = TileMap.new()
	new_floor.tile_set = tile_set
	
	for n in 25:
		new_floor.set_cell(0, Vector2i(n, 5), 0, Vector2(0, 0), 0)
		
	add_child(new_floor)

