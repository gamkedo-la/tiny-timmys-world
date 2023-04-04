extends Camera2D

const PIXELS_PER_PIXEL = 2.0

var factor: float = 1.0 / PIXELS_PER_PIXEL

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	zoom = Vector2(factor, factor)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
