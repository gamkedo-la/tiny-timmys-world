extends ScrollingTile



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)
	_check_to_reset()
	

func _check_to_reset() -> void:
	if position.x < -viewport_width:
		position.x += viewport_width * 2
