extends AIState

var change_state = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(delta: float) -> void:
	state_check()
	time_in_state += delta
	pass


func physics_process(delta: float) -> void:
	actor.physics_process(delta)


func state_check()->void:
	if time_in_state > 1.0:
		_ai_state_machine.transition_to('TongueAtk', {})
	pass

func enter(msg:Dictionary = {}) -> void:
	actor.ani_player_play("TongueTell")

	time_in_state = 0.0
	pass

func exit() -> void:
	pass
