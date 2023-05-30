extends PlayerState

var time_immune: float = 0.2
var time_elapsed: float = 0

func unhandled_input(event:InputEvent) -> void:
	player.unhandled_input(event)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(delta: float) -> void:
	time_elapsed += delta
	state_check()

	pass


func physics_process(delta: float) -> void:
	super(delta)
	player.physics_process(delta)


func state_check()->void:
	if time_elapsed >= time_immune:
		if player.is_grounded:
			if abs(player.direction) > 0.01:
				_state_machine.transition_to('Run', {})
			else:
				_state_machine.transition_to('Idle', {})
		else:
			if player.is_jumping:
				if player.jump:
					_state_machine.transition_to('Jump', {})
	else:
		pass
		
		
func predict_land() -> void:
	player.lndseek.enabled = true
	player.lndseek.force_raycast_update()
	if player.lndseek.is_colliding():
#		print_debug("Land anticipated. Current Tree Node: ", player.ani_get_current_node())
#		player.ani_state_travel("land")
		pass
	else:
#		player.ani_state_travel("fall")
		pass
#	player.lndseek.enabled = false

func enter(msg:Dictionary = {}) -> void:
	print_debug("Entering Stomp")
	time_elapsed = 0

func exit() -> void:

	print_debug("Exiting Stomp")
	player.is_stomping = false
