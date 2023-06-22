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
	var player_position = PlayerVars.player.position
	var hand = actor.get_node("LeftHand")
	var hand_position = hand.position
	var normalized_direction = (player_position - hand_position).normalized()
	hand.velocity.x = hand.SPEED * normalized_direction.x
	hand.velocity.y = hand.SPEED * normalized_direction.y
	hand.move_and_slide()
		
	actor.physics_process(delta)


func state_check()->void:
	if time_in_state > 2.0:
		var chance = RNG.randf_range(0.0, 1.0)
		if chance > 0.8:		
			_ai_state_machine.transition_to('LeftFistReturn', {})
	pass

func enter(msg:Dictionary = {}) -> void:
	RNG.randomize()

	time_in_state = 0.0
	pass

func exit() -> void:
	pass
	
		
