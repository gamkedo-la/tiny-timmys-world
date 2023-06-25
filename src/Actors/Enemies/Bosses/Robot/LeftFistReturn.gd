extends AIState

@onready var RNG = RandomNumberGenerator.new()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(delta: float) -> void:
	state_check()
	time_in_state += delta
	pass


func physics_process(delta: float) -> void:
	if !PlayerVars.player:
		return
	actor.fist_return("LeftHand")
	actor.physics_process(delta)


func state_check()->void:
	if actor.fist_is_back_in_position:
			_ai_state_machine.transition_to('Idle', {})
	pass

func enter(msg:Dictionary = {}) -> void:
	RNG.randomize()
	actor.fist_is_back_in_position = false	
	time_in_state = 0.0
	pass

func exit() -> void:
	pass
	
		
