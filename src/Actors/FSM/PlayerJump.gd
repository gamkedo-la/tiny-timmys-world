extends PlayerState

var jump_top_threshold: float = 100.0

func unhandled_input(event:InputEvent)->void:
	player.unhandled_input(event)

func physics_process(delta:float)->void:
	player.physics_process(delta)

func process(delta:float)->void:
#	player.facing_direction()
	state_check()

func state_check()->void:
#	print("Grounded: ", player.is_grounded, " OnWall: ", player.is_onwall, " RayGround: ", player.RayGround)
	if player.is_grounded:
		if abs(player.direction) < 0.01:
			_state_machine.transition_to("Idle")
			return
		else:
			_state_machine.transition_to("Run")
			return
	else:
		#add wall checks here and double jump logic
		
	
		var y:float = player.velocity.y
		if abs(y) < jump_top_threshold:
#			player.ani_state_travel("jump_reset")
			pass
		elif y > 0.0:
			predict_land()
#			player.ani_state_travel("fall")

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

func enter(msg:Dictionary = {})->void:
	player.speed = player.run_speed
#	player.ani_state_travel("jump_lift")

func exit() -> void:
	player.lndseek.enabled = false
