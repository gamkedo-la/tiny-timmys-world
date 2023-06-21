extends AIState

@onready var RNG = RandomNumberGenerator.new()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(delta: float) -> void:
	state_check()
	time_in_state += delta
	pass


func physics_process(delta: float) -> void:
	# Prevent crash when AggressiveFlyingEnemy is on screen when restarting level
	if !PlayerVars.player:
		return
	var player_position = PlayerVars.player.position
	var actor_position = actor.position
	var normalized_direction = (player_position - actor_position).normalized()
	actor.velocity.x = actor.SPEED * normalized_direction.x
	actor.velocity.y = actor.SPEED * normalized_direction.y
	actor.move_and_slide()
		
	actor.physics_process(delta)


func state_check()->void:
	if time_in_state > 2.0:
		var chance = RNG.randf_range(0.0, 1.0)
		if chance > 0.8:		
			_state_machine.transition_to('Fly', {})
	pass

func enter(msg:Dictionary = {}) -> void:
	RNG.randomize()

	time_in_state = 0.0
	pass

func exit() -> void:
	pass
	
		
