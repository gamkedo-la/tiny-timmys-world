extends ParallaxBackground

var scroll_velo = Vector2(Global.LEVEL_SPEED, 0.0)
@onready var plax_cam: Camera2D = $BackCamera2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	plax_cam.offset -= scroll_velo * delta
	pass
