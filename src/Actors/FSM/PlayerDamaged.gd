extends PlayerState

var time_immune: float = 1.0
var time_elapsed: float = 0

func unhandled_input(event:InputEvent) -> void:
	player.unhandled_input(event)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(delta: float) -> void:
	time_elapsed += delta
	state_check()

	pass


func physics_process(delta: float) -> void:
	super(delta)
	player.physics_process(delta)


func state_check()->void:
	if time_elapsed >= time_immune:
		if player.is_grounded:
			if abs(player.direction) > 0.01:
				_state_machine.transition_to('Run', {})
			else:
				_state_machine.transition_to('Idle', {})
		else:
			if player.is_jumping:
				if player.jump:
					_state_machine.transition_to('Jump', {})
	else:
		pass

func enter(msg:Dictionary = {}) -> void:
	player.animation_player.play("Damaged")
	player.sprite.material.shader = load("res://src/Shaders/RedShader.gdshader")
	print_debug("Entering damaged")
	time_elapsed = 0

func exit() -> void:
	player.animation_player.stop()
	player.sprite.material.shader = load("res://src/Shaders/player.gdshader")
	print_debug("Exiting damaged")
	player.is_damaged = false
