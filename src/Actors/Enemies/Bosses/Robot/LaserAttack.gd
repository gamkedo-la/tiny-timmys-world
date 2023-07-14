extends AIState

var laser_fired = false
@onready var RNG = RandomNumberGenerator.new()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(delta: float) -> void:
	state_check()
	time_in_state += delta
	pass


func physics_process(delta: float) -> void:
	if !laser_fired:
		actor.fire_laser(PlayerVars.player.global_position)
		laser_fired = true
	actor.physics_process(delta)


func state_check()->void:
	if time_in_state > 3.0 && laser_fired:
		_ai_state_machine.transition_to('Idle', {})
	pass

func enter(msg:Dictionary = {}) -> void:
#	actor.ani_player_play("Idle")
	actor.audio_stream_player.stream = actor.laser_fire_sfx
	actor.audio_stream_player.play()
	laser_fired = false
	time_in_state = 0.0
	pass

func exit() -> void:
	actor.retract_laser()
	pass
