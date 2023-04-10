extends Camera2D

@onready var noise = FastNoiseLite.new()
var noise_y = 0
@export var max_offset = Vector2(1,1)
@export var max_roll = 0.1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var con_res
	if not Global.is_connected("screen_shake", shake):
		con_res = Global.connect("screen_shake", shake)
		assert(con_res == OK)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	shake(40.0)
	pass


func shake(amount: float) -> void:	
	noise_y += 1 
	rotation = max_roll * amount * noise.get_noise_2d(noise.seed, noise_y)
	offset.x = max_offset.x * amount * noise.get_noise_2d(noise.seed*2, noise_y)
	offset.y = max_offset.y * amount * noise.get_noise_2d(noise.seed*3, noise_y)
