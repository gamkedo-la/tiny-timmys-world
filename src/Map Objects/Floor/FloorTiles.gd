extends TileMap

var viewport_width: int = 0
var viewport_height: int = 0
var pixel_counter: float
const SPEED: float = -20.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	viewport_width = get_viewport_rect().size.x
	viewport_height = get_viewport_rect().size.y
	pixel_counter = 0
	_spawn_new_floor_cell()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var position_increment = SPEED * delta
	pixel_counter += -position_increment
	position.x += position_increment
	print_debug(pixel_counter)
	
	if pixel_counter > cell_quadrant_size:
		print_debug("Spawning")
		_spawn_new_floor_cell()
		pixel_counter = 0


func _spawn_new_floor_cell() -> void:
	var spawn_coords: Vector2i = Vector2i(5, 5)
	set_cell(0,  spawn_coords, 0, Vector2(0,0), 0)
