extends CharacterBody2D

class_name ScrollingTile

@export var SPEED: = -20.0
var viewport_width: = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	viewport_width = get_viewport_rect().size.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# position.x+=SPEED
	velocity.x = SPEED
	move_and_slide()
