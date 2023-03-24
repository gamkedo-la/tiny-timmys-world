extends Node2D

var viewport_width: int = 0
var viewport_height: int = 0
var pixel_cell_counter: float
var pixel_total_movement_counter: float
var floor_tilemap
const SPEED: float = -16.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	floor_tilemap = $FloorTiles
	
	viewport_width = get_viewport_rect().size.x
	viewport_height = get_viewport_rect().size.y
	pixel_cell_counter = 0
	pixel_total_movement_counter = 0
	var spawn_coords: Vector2i = Vector2i(5, 5)
	var spawn_coords_2: Vector2i = Vector2i(10, 5)
	_spawn_new_floor_cell(spawn_coords)
	_spawn_new_floor_cell(spawn_coords_2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var position_increment = SPEED * delta
	pixel_cell_counter += -position_increment
	pixel_total_movement_counter += -position_increment
	floor_tilemap.position.x += position_increment
	print_debug(pixel_cell_counter)
	
	if pixel_cell_counter > floor_tilemap.cell_quadrant_size:
		print_debug("Spawning")
		var spawn_coords: Vector2i = Vector2i(5 + pixel_total_movement_counter, 5)
		_spawn_new_floor_cell(spawn_coords)
		pixel_cell_counter = 0


func _spawn_new_floor_cell(coords: Vector2i) -> void:
	# var spawn_coords: Vector2i = Vector2i(5, 5)
	floor_tilemap.set_cell(0,  coords, 0, Vector2(0,0), 0)
