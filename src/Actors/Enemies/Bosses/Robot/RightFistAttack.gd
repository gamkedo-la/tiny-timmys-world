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
	actor.fist_launch("RightHand")
	
	actor.physics_process(delta)


func state_check()->void:
	if time_in_state > 2.0:
		var chance = RNG.randf_range(0.0, 1.0)
		if chance > 0.8:		
			_ai_state_machine.transition_to('RightFistReturn', {})
	pass

func enter(msg:Dictionary = {}) -> void:
	RNG.randomize()
	actor.audio_stream_player.stream = actor.fist_fire_sfx
	actor.audio_stream_player.play()
	time_in_state = 0.0
	pass

func exit() -> void:
	pass
	
		
