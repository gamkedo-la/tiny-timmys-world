extends AIState

@onready var RNG = RandomNumberGenerator.new()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(delta: float) -> void:
	state_check()
	time_in_state += delta
	pass


func physics_process(delta: float) -> void:
	if actor.is_on_wall() and actor.leave_counter > 0:
		actor.dir.x *= -1.0
		actor.leave_counter -= 1
		if actor.leave_counter == 0:
			actor.collision_mask = 9
#		SPEED *= -1.0
	actor.velocity.x = actor.SPEED * actor.dir.x
	actor.velocity.y = 0
		
	if actor.dir.is_equal_approx(Vector2.LEFT) and actor.actor_body.scale.x < 0.0:
		actor.actor_body.scale.x *= -1.0
	if actor.dir.is_equal_approx(Vector2.RIGHT) and actor.actor_body.scale.x > 0.0:
		actor.actor_body.scale.x *= -1.0
		
	actor.move_and_slide()
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
