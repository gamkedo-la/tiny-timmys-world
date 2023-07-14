extends AIState

# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(delta: float) -> void:
	state_check()
	time_in_state += delta
	pass


func physics_process(delta: float) -> void:
	actor.physics_process(delta)


func state_check()->void:
	if time_in_state > 1.0:
		_ai_state_machine.transition_to('LaserAttack', {})
	pass

func enter(msg:Dictionary = {}) -> void:
	actor.ani_player_play("Laser")
	actor.audio_stream_player.stream = actor.laser_tell_sfx
	actor.audio_stream_player.play()
	time_in_state = 0.0
	pass

func exit() -> void:
	pass
