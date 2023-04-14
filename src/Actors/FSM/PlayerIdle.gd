extends PlayerState


func unhandled_input(event:InputEvent) -> void:
	player.unhandled_input(event)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(delta: float) -> void:
	state_check()

	pass


func physics_process(delta: float) -> void:
	super(delta)
	player.physics_process(delta)


func state_check()->void:
	
	if player.is_grounded:
		if abs(player.direction) > 0.01:
			_state_machine.transition_to('Run', {})
	else:
		if player.is_jumping:
			if player.jump:
				_state_machine.transition_to('Jump', {})
	pass

func enter(msg:Dictionary = {}) -> void:
	player.speed = player.run_speed
#	player.ani_player_play("Idle")

	
	pass

func exit() -> void:
	pass
