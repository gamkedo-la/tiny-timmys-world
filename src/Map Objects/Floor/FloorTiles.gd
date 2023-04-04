extends Node2D

@export var tile_set: TileSet

var min_coords_x: int
var max_coords_x: int

var min_coords_y: int
var max_coords_y: int

const SPEED: float = Global.LEVEL_SPEED
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print_debug("Tile Set Size: ", tile_set.tile_size.x)
	
	min_coords_x = 0
	max_coords_x = get_viewport_rect().size.x / tile_set.tile_size.x
	
	print_debug("max_coords_x: ",max_coords_x)

	min_coords_y = 0
	max_coords_y = get_viewport_rect().size.y / tile_set.tile_size.y
	print_debug("max_coords_y: ",max_coords_x)
	
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
	
	for n in max_coords_x:
		print_debug("Adding cell to coords: ", Vector2i(n, max_coords_y))
		new_floor.set_cell(0, Vector2i(n, max_coords_y), 0, Vector2(2, 0), 0)
	
	#TODO: Decoration tiles
	for n in max_coords_x:
		print_debug("Adding decoration cell to coords: ", Vector2i(n, max_coords_y))
		new_floor.set_cell(1, Vector2i(n, max_coords_y), 0, Vector2(6, 1), 0)
		
	add_child(new_floor)
	
func _spawn_new_random_floor() -> void:
	var new_floor: TileMap = TileMap.new()
	new_floor.tile_set = tile_set
	
	for n in max_coords_x:
		new_floor.set_cell(0, Vector2i(n, max_coords_y), 0, Vector2(2, 0), 0)
	
	new_floor.position.x += get_viewport_rect().size.x
	add_child(new_floor)	

