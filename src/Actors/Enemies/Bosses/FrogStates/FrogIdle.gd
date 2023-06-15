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
			pass
			#_ai_state_machine.transition_to('StompTell', {})
		elif chance > 0.5:
			pass
			#_ai_state_machine.transition_to('TongueTell', {})
		elif chance > 0.3:
			pass
			#_ai_state_machine.transition_to('SpawnFly', {})
	pass

func enter(msg:Dictionary = {}) -> void:
	RNG.randomize()
	actor.ani_player_play("Idle")

	time_in_state = 0.0
	pass

func exit() -> void:
	pass
