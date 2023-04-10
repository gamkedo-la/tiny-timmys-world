extends AIState

# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(delta: float) -> void:

	pass


func physics_process(delta: float) -> void:
	actor.physics_process(delta)



func state_check()->void:

	pass

func enter(msg:Dictionary = {}) -> void:
	actor.ani_player_play("Idle")

	time_in_state = 0.0
	pass

func exit() -> void:
	pass
