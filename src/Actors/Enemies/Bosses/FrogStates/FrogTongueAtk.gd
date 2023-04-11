extends AIState

var tongue_fired = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(delta: float) -> void:
	state_check()
	time_in_state += delta
	pass


func physics_process(delta: float) -> void:
	if !tongue_fired:
		actor.fire_tongue(PlayerVars.player.global_position)
		tongue_fired = true
	actor.physics_process(delta)


func state_check()->void:
	if time_in_state > 3.0 && tongue_fired:
		_ai_state_machine.transition_to('Idle', {})
	pass

func enter(msg:Dictionary = {}) -> void:
#	actor.ani_player_play("Idle")
	tongue_fired = false
	time_in_state = 0.0
	pass

func exit() -> void:
	actor.retract_tongue()
	pass
