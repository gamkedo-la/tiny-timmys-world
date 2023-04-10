extends AIState

var has_stomped: bool = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(delta: float) -> void:
	state_check()
	time_in_state += delta
	pass


func physics_process(delta: float) -> void:
	if !has_stomped:
		actor.velocity.y = -700
		has_stomped = true
	actor.physics_process(delta)



func state_check()->void:
	if time_in_state > 2.0:
		_ai_state_machine.transition_to('Idle', {})
	pass

func enter(msg:Dictionary = {}) -> void:
#	actor.ani_player_play("Idle")
	has_stomped = false
	time_in_state = 0.0
	
#	Global.emit_signal("screen_shake", 3.0)
	pass

func exit() -> void:
	pass
