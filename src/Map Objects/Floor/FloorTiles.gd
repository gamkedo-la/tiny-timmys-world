extends Node2D

@export var tile_set: TileSet
@export var floor_hole_spawn_probability: float

var min_coords_x: int
var max_coords_x: int

var min_coords_y: int
var max_coords_y: int

var SPEED: float = Global.LEVEL_SPEED

var rng: RandomNumberGenerator
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	min_coords_x = 0
	max_coords_x = get_viewport_rect().size.x / tile_set.tile_size.x
	

	min_coords_y = 0
	max_coords_y = get_viewport_rect().size.y / tile_set.tile_size.y
	
	rng = RandomNumberGenerator.new()
	
	_spawn_initial_random_floor()
	_spawn_new_random_floor()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for child in get_children():
		child.position.x += SPEED * delta
		if child.position.x < -get_viewport_rect().size.x:
			child.queue_free()
			_spawn_new_random_floor()
	

func _spawn_initial_random_floor() -> void:
	var new_floor: TileMap = TileMap.new()
	new_floor.tile_set = tile_set
	
	var floor_cells_coord_list = []
	for n in max_coords_x:
		floor_cells_coord_list.append(Vector2i(n, max_coords_y))
	
	new_floor.set_cells_terrain_connect(0, floor_cells_coord_list, 0, 0, true)
	
	var decorator_cells_coord_list = []
	for n in max_coords_x:
		decorator_cells_coord_list.append(Vector2i(n, max_coords_y - 1))
	
	new_floor.set_cells_terrain_connect(0, decorator_cells_coord_list, 0, 1, true)
		
	add_child(new_floor)
	
func _spawn_new_random_floor() -> void:
	var new_floor: TileMap = TileMap.new()
	new_floor.tile_set = tile_set
	
	var floor_cells_coord_list = []
	var decorator_cells_coord_list = []
	var hazard_cells_coord_list = []
	for n in max_coords_x:
		if rng.randf_range(0.0, 1.0) > floor_hole_spawn_probability:
			floor_cells_coord_list.append(Vector2i(n, max_coords_y))
			decorator_cells_coord_list.append(Vector2i(n, max_coords_y - 1))
		
			if (rng.randf_range(0.0, 1.0) < floor_hole_spawn_probability): 
				hazard_cells_coord_list.append(Vector2i(n, max_coords_y - 1))
	
	new_floor.set_cells_terrain_connect(0, floor_cells_coord_list, 0, 0, true)
	new_floor.set_cells_terrain_connect(0, decorator_cells_coord_list, 0, 1, true)
	new_floor.set_cells_terrain_connect(0, hazard_cells_coord_list, 0, 2, true)
	
	new_floor.position.x += get_viewport_rect().size.x
	add_child(new_floor)	

