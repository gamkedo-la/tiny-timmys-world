extends AIState

@onready var RNG = RandomNumberGenerator.new()

var is_back_in_position = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(delta: float) -> void:
	state_check()
	time_in_state += delta
	pass


func physics_process(delta: float) -> void:
	if !PlayerVars.player:
		return
	var hand = actor.get_node("LeftHand")
	var hand_initial_position = hand.initial_position
	var hand_position = hand.position
	var normalized_direction = (hand_initial_position - hand_position).normalized()
	hand.velocity.x = hand.SPEED * normalized_direction.x
	hand.velocity.y = hand.SPEED * normalized_direction.y
	hand.move_and_slide()
	
	if(round(hand_position.y) == hand_initial_position.y):
		is_back_in_position = true
		
	actor.physics_process(delta)


func state_check()->void:
	if is_back_in_position:
			_ai_state_machine.transition_to('Idle', {})
	pass

func enter(msg:Dictionary = {}) -> void:
	RNG.randomize()

	time_in_state = 0.0
	pass

func exit() -> void:
	pass
	
		
