extends PlayerState

func unhandled_input(event:InputEvent) -> void:
	if event.is_action_pressed("attack"):
		_state_machine.transition_to("Attack")
	else:
		player.unhandled_input(event)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(delta: float) -> void:
#	player.facing_direction()
	state_check()

func physics_process(delta: float) -> void:
	player.physics_process(delta)

func state_check()->void:
#	print_debug(player.ani_get_current_node())

	if player.is_grounded:
		if player.down > 0.01:
#			if player.jump:
#				_state_machine.transition_to("Slide", {})
#			elif abs(player.direction) < 0.01:
#				_state_machine.transition_to("Crouch", {})
#			else:
#				_state_machine.transition_to("Crouch_walk", {})
			pass
		else:
			if abs(player.direction) < 0.01:
				_state_machine.transition_to('Idle', {})
	else:
		if player.is_jumping:
			if player.jump:
				_state_machine.transition_to("Jump", {})
		else:
#			player.timer.wait_time = player.jump_buffer
#			player.timer.start()
#			var y:float = player.velocity.y
#			if abs(y) < player.jump_top_speed:
#				_state_machine.transition_to('Jump_top', {})
#			elif y > 0.0:
#				_state_machine.transition_to('Jump_fall', {})
#			elif y < 0.0:
#				_state_machine.transition_to('Jump', {})
			pass
			
func enter(msg:Dictionary = {}) -> void:
	player.speed = player.run_speed
#	player.ani_state_travel("run")
