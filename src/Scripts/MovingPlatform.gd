extends Node2D

const SPEED: float = -20.0



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$PlatformBody.velocity.x = SPEED
	$PlatformBody.move_and_slide()
