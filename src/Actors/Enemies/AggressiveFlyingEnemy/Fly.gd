extends AIState

@onready var RNG = RandomNumberGenerator.new()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(delta: float) -> void:
	state_check()
	time_in_state += delta
	pass


func physics_process(delta: float) -> void:
	actor.physics_process(delta)


func state_check()->void:
	if time_in_state > 2.0:
		var chance = RNG.randf_range(0.0, 1.0)
		if chance > 0.8:
			print_debug("Transition soon")
			_state_machine.transition_to('Attack', {})
	pass

func enter(msg:Dictionary = {}) -> void:
	RNG.randomize()

	time_in_state = 0.0
	pass

func exit() -> void:
	pass
